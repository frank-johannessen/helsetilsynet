activityFeed = {};

activityFeed.api = new function () {
    var self = this;

    // updates
    this.postUpdate = function (statusUpdateText, source, topic) {
        if (topic) {
            return self.callService($.postJSON, '/activityFeed/topics/' + encodeURIComponent(topic) + '/updates', { text: statusUpdateText, source: source });
        } else {
            return self.callService($.postJSON, '/activityFeed/updates', { text: statusUpdateText, source: source });
        }
    };

    this.removeUpdate = function (update) {
        return self.callService($.deleteJSON, '/activityFeed/updates/' + encodeURIComponent(update.id()));
    };

    this.getUpdates = function (topic, searchTerm, dateFrom, pageSize) {
        var queryString = '?dateFrom=' + encodeURIComponent(dateFrom) + '&pageSize=' + pageSize + '&searchTerm=' + encodeURIComponent(searchTerm);

        if (topic) {
            return self.callService($.getJSON, '/activityFeed/topics/' + encodeURIComponent(topic) + '/updates' + queryString);
        }
        else {
            return self.callService($.getJSON, '/activityFeed/updates' + queryString);
        }
    };

    // subscribe
    this.subscribe = function (topic) {
        return self.callService($.postJSON, '/activityFeed/subscriptions', { topic: topic });
    };

    this.unsubscribe = function (topic) {
        return self.callService($.deleteJSON, '/activityFeed/subscriptions/' + encodeURIComponent(topic));
    };



    //comments
    this.postComment = function (updateId, commentText) {
        return self.callService($.postJSON, '/activityFeed/updates/' + encodeURIComponent(updateId) + '/comments', { text: commentText });
    };

    this.removeComment = function (updateId, commentId) {
        return self.callService($.deleteJSON, '/activityFeed/updates/' + encodeURIComponent(updateId) + '/comments/' + encodeURIComponent(commentId));
    };


    // likes
    this.likeUpdate = function (updateId) {
        return self.callService($.postJSON, '/activityFeed/updates/' + encodeURIComponent(updateId) + '/likes', {});
    };

    this.removeLikeFromUpdate = function (updateId) {
        return self.callService($.deleteJSON, '/activityFeed/updates/' + encodeURIComponent(updateId) + '/likes');
    };



    // private
    this.callService = function () {
        var functionToCall = arguments[0];
        return functionToCall.apply(this, Array.prototype.slice.call(arguments).skip(1)).fail(self.handleError);
    };

    this.handleError = function (exception) {
        var errorText = "ERROR: status - " + exception.status + ", message: " + exception.statusText;
        alert(errorText);
    };
};
$.postJSON = function (url, data, callback) {
    return $.ajax({
        url: url,
        data: JSON.stringify(data),
        type: "POST",
        processData: true,
        contentType: "application/json; charset=utf-8",
        timeout: 10000,
        dataType: "json",
        success: callback
    });
};

$.deleteJSON = function (url, data, callback) {
    return $.ajax({
        url: url,
        data: JSON.stringify(data),
        type: "DELETE",
        processData: true,
        contentType: "application/json; charset=utf-8",
        timeout: 10000,
        dataType: "json",
        success: callback
    });
};

/*    fancy textearea    */
(function ($) {

    var methods = {
       init: function (options) {
           this.each(function () {
               var fieldSet = $(this);
               var fake = $('<div class="fake-input"><p></p></div>');
               var className = fieldSet.attr('class');
               fake.addClass(className);
               fake.find('p').text(fieldSet.find('legend').text());
               var editorContainer = fieldSet.before(fake).hide();

               var editor = editorContainer.find('textarea').blur(function () {
                   if (this.value.length > 0)
                       return;
                   fake.show();
                   editorContainer.hide();
               }).change(function () {
                   if (this.value.length > 0 || $(this).is(":focus"))
                       return;
                   fake.show();
                   editorContainer.hide();
               });

               jQuery.data(this, 'fakeInput', fake);

               fake.click(function () {
                   fake.hide();
                   editorContainer.show();
                   editor.focus();
               });
           });
       },

       showInput: function() {
           var fieldSet = jQuery.data(this[0],'fakeInput');
           fieldSet.click();
       }
    };

    $.fn.fakeInput = function (methodOrOptions) {
        if ( methods[methodOrOptions] ) {
            return methods[methodOrOptions].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof methodOrOptions === 'object' || ! methodOrOptions ) {
            // Default to "init"
            return methods.init.apply( this, arguments );
        } else {
            $.error( 'Method ' +  method + ' does not exist on jQuery.tooltip' );
        }   
    };
})(jQuery);

/*    subscribe/unsubscribe topic button    */
$.fn.subscribeUnsubscribeButton = function () {
    this.each(function () {
        if ($(this).data('topic') == null) {
            throw "Cannot create subscribeUnsubscribeButton without topic assigned";
        }
        
        $(this).click(function () {
            var $button = $(this);

            if ($button.hasClass('busy')) {
                return;
            }

            var topic = $button.data('topic');

            $button.addClass('busy');

            if ($button.hasClass('subscribed')) {
                activityFeed.api.unsubscribe(topic).then(function () {
                    $button.removeClass('subscribed');
                }).always(function () {
                    $button.removeClass('busy');
                });
            } else {
                activityFeed.api.subscribe(topic).then(function () {
                    $button.addClass('subscribed');
                }).always(function () {
                    $button.removeClass('busy');
                });
            }
        });
    });
};

/*
    asyncCommand - used instead of click, while using deferred results,
                   supports enable, allowed and inProgress
*/
ko.asyncCommand = function (exec, enabled, allowed) {
    var command = function () {
        if (command.isEnabled() == false) {
            return;
        }
        command.isInProgress(true);
        var result = exec.apply(this, arguments);
        result.always(function () { command.isInProgress(false); });
        return result;
    };

    command.isInProgress = ko.observable(false);
    command.isAllowed = ko.computed(function () {
        return allowed == undefined || allowed();
    });
    command.isEnabled = ko.computed(function () { return (enabled == undefined || enabled()) && command.isAllowed() && command.isInProgress() == false; });

    return command;
};



/*
Can be called with asyncCommand 

Can be called with confirm function, that is used to confirm command execution
Confirmation could be standard confirm that return true/false or function that returns deferred object
*/
ko.bindingHandlers.command = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {

        var valueAccessorResult = valueAccessor();

        if (typeof (valueAccessorResult) != "function") throw new Error("Command value have to be function");

        var commandConfirm = allBindingsAccessor()["commandConfirm"];

        var executeAccessor;


        // command created with action + confirmation
        if (commandConfirm) {
            if (typeof (commandConfirm) != "function") throw new Error("CommandConfirm value have to be function");

            executeAccessor = function () {
                return function () {
                    var result = commandConfirm(viewModel);

                    // built-in CONFIRM handling
                    if (typeof (result) == "boolean") {
                        if (result) {
                            valueAccessorResult.apply(this, arguments);
                        }
                    }

                    // deffered confirm handling (like jquery-ui Dialog)
                    else {
                        if (!result.then) throw new Error("CommandConfirm result is not deferred object");

                        result.then(function (deferredResult) {
                            if (deferredResult) {
                                valueAccessorResult.apply(this, arguments);
                            }
                        });
                    }

                };
            };
        }
        // command created with action only
        else {
            executeAccessor = function () {
                return function () {
                    valueAccessor().apply(this, arguments);
                };
            };
        }

        ko.bindingHandlers.click.init(element, executeAccessor, allBindingsAccessor, viewModel);

        var enabledAccessor = function () {
            return { disabled: ko.computed(function () { return !valueAccessorResult.isEnabled(); }) };
        };


        // ***
        // *** disabled attribute for button and anchor
        // ***
        if (element.tagName == "BUTTON" || element.tagName == "INPUT") {
            ko.bindingHandlers.attr.update(element, enabledAccessor, allBindingsAccessor, viewModel);
            var attrSubscription = valueAccessorResult.isEnabled.subscribe(function () {
                ko.bindingHandlers.attr.update(element, enabledAccessor, allBindingsAccessor, viewModel);
            });

            // dispose action
            ko.utils.domNodeDisposal.addDisposeCallback(element, function () {
                attrSubscription.dispose();
            });
        }


        // ***
        // *** css binding for other elements
        // ***
        ko.bindingHandlers.css.update(element, enabledAccessor, allBindingsAccessor, viewModel);
        var cssSubscription = valueAccessorResult.isEnabled.subscribe(function () {
            ko.bindingHandlers.css.update(element, enabledAccessor, allBindingsAccessor, viewModel);
        });
        // dispose action
        ko.utils.domNodeDisposal.addDisposeCallback(element, function () {
            cssSubscription.dispose();
        });
    },

    // unsubscribe
    destroy: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        var commandAccessor;
        if (typeof (valueAccessor()) == "function") {
            commandAccessor = valueAccessor();
        }
        else {
            commandAccessor = valueAccessor().action;
        }
        commandAccessor.isEnabled.unsubscribe();
    }
};

/*    apply jQuery plugin on element    */
ko.bindingHandlers.jQuery = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        var plugin = valueAccessor();
        $(element)[plugin]();
    }
};

/*    hook for onchange event, that will be called, when observable value changed  */
ko.bindingHandlers.valueExt = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        ko.bindingHandlers.value.init(element, valueAccessor, allBindingsAccessor, viewModel);
    },

    update: function (element, valueAccessor, allBindingsAccessor, viewModel) {
        ko.bindingHandlers.value.update(element, valueAccessor, allBindingsAccessor, viewModel);
        $(element).change();
    }
};
/* 
   ***** ***** ***** ***** ***** ***** 
   ***** 
   *****  Date
   ***** 
   ***** ***** ***** ***** ***** ***** 
*/


/*    toISOString - support for IE    */
if (!Date.prototype.toISOString) {

    (function () {

        function pad(number) {
            var r = String(number);
            if (r.length === 1) {
                r = '0' + r;
            }
            return r;
        }

        Date.prototype.toISOString = function () {
            return this.getUTCFullYear()
                + '-' + pad(this.getUTCMonth() + 1)
                + '-' + pad(this.getUTCDate())
                + 'T' + pad(this.getUTCHours())
                + ':' + pad(this.getUTCMinutes())
                + ':' + pad(this.getUTCSeconds())
                + '.' + String((this.getUTCMilliseconds() / 1000).toFixed(3)).slice(2, 5)
                + 'Z';
        };

    } ());
}

/*    parse - supports for IE   */
(function (Date, undefined) {
    var origParse = Date.parse, numericKeys = [1, 4, 5, 6, 7, 10, 11];
    Date.parse = function (date) {
        var timestamp, struct, minutesOffset = 0;

        // ES5 �15.9.4.2 states that the string should attempt to be parsed as a Date Time String Format string
        // before falling back to any implementation-specific date parsing, so that�s what we do, even if native
        // implementations could be faster
        //              1 YYYY                2 MM       3 DD           4 HH    5 mm       6 ss        7 msec        8 Z 9 �    10 tzHH    11 tzmm
        //ORIGINAL    /^(\d{4}|[+\-]\d{6})(?:-(\d{2})(?:-(\d{2}))?)?(?:T(\d{2}):(\d{2})(?::(\d{2})(?:\.(\d{3}))?)?(?:(Z)|([+\-])(\d{2})(?::(\d{2}))?)?)?$/.exec(date)
        if ((struct = /^(\d{4}|[+\-]\d{6})(?:-(\d{2})(?:-(\d{2}))?)?(?:T(\d{2}):(\d{2})(?::(\d{2})(?:\.(\d{3,}))?)?(?:(Z)|([+\-])(\d{2})(?::(\d{2}))?)?)?$/.exec(date))) {
            // avoid NaN timestamps caused by �undefined� values being passed to Date.UTC
            for (var i = 0, k; (k = numericKeys[i]); ++i) {
                struct[k] = +struct[k] || 0;
            }

            // allow undefined days and months
            struct[2] = (+struct[2] || 1) - 1;
            struct[3] = +struct[3] || 1;

            if (struct[8] !== 'Z' && struct[9] !== undefined) {
                minutesOffset = struct[10] * 60 + struct[11];

                if (struct[9] === '+') {
                    minutesOffset = 0 - minutesOffset;
                }
            }

            // ms structure could be max 3 decimal places
            var milliseconds = (struct[7] + "").length;
            if ( milliseconds > 3) {
                milliseconds = Math.round(struct[7] / Math.pow(10, milliseconds - 3));
            }
            else {
                milliseconds = struct[7];
            }

            timestamp = Date.UTC(struct[1], struct[2], struct[3], struct[4], struct[5] + minutesOffset, struct[6], milliseconds);
        }
        else {
            timestamp = origParse ? origParse(date) : NaN;
        }

        return timestamp;
    };
} (Date));



/* 
   ***** ***** ***** ***** ***** ***** 
   ***** 
   *****  Array
   ***** 
   ***** ***** ***** ***** ***** ***** 
*/

/*    take - take first COUNT elements of array  */
Array.prototype.take = function(count) {
    return this.slice(0, count);
};

/*    skip - skips first COUNT elements of array   */
Array.prototype.skip = function(count) {
    return this.slice(count, this.length);
};

/*    takeUpToMaxOrMin - when there is more than Max elements, then min is returned,
                         otherwise min elements is returned
*/
Array.prototype.takeUpToMaxOrMin = function (minCount, maxCount) {
    if (this.length > maxCount) {
        return this.take(minCount);
    }
    return this.take(maxCount);
};
activityFeed.LikeViewModel = function (currentUser) {
    var self = this;

    this.user = ko.observable();
};

activityFeed.UpdatesMapper = function (user, removeUpdateHandler) {
    var self = this;

    var commentMapping =
        {
            'publisher': {
                create: function (data) { return data.data; }
            }
        };

    var likeMapping =
        {
            'user': {
                create: function (data) { return data.data; }
            }
        };

    var updateMapping = function (updateViewModel) {
        //jak  przekazac w mapowaniu removeCommentHandler????

        this.comments = { create: function (data) { return self.mapCommentToCommentViewModel(data.data, updateViewModel); } };
        this.likes = {
            create: function (data) {
                var like = new activityFeed.LikeViewModel(user);
                return ko.mapping.fromJS(data.data, likeMapping, like);
            }
        };

        this.publisher =
            {
                create: function (data) {
                    return data.data;
                }
            };
    };

    this.mapLikeToLikeViewModel = function (like) {
        var likeViewModel = new activityFeed.LikeViewModel(user);
        return ko.mapping.fromJS(like, likeMapping, likeViewModel);
    };

    this.mapCommentToCommentViewModel = function (comment, update) {
        var commentViewModel = new activityFeed.CommentViewModel(user, update.removeCommentHandler);
        return ko.mapping.fromJS(comment, commentMapping, commentViewModel);
    };

    this.mapUpdateToUpdateViewModel = function (update) {
        update.publishedOn = new Date(Date.parse(update.publishedOn));
        var updateViewModel = new activityFeed.UpdateViewModel(user, removeUpdateHandler);
        var mapping = new updateMapping(updateViewModel);
        updateViewModel = ko.mapping.fromJS(update, mapping, updateViewModel);
        return updateViewModel;
    };

    this.mapUpdates = function (updates) {
        return $.map(updates, function (update) {
            return self.mapUpdateToUpdateViewModel(update);
        });
    };
};

activityFeed.ActivityFeedViewModel = function (options) {
    var self = this;

    var removeUpdate = function (update) {
        var promise = activityFeed.api.removeUpdate(update).then(function () {
            self.updates.remove(update);
        });
        return promise;
    };

    var updatesMapper = new activityFeed.UpdatesMapper(options.user, removeUpdate);
    this.updates = ko.observableArray(updatesMapper.mapUpdates(options.updates));


    this.newPostText = ko.observable("");

    this.initialize = function () {
        if (!options.topic) {
            options.topic = null;
        }
    };


    this.postUpdate = ko.asyncCommand(
        function () {
            var postUpdate;
            if (options.topic)
                postUpdate = function (text) { return activityFeed.api.postUpdate(text, options.source, options.topic); };
            else
                postUpdate = function (text) { return activityFeed.api.postUpdate(text, options.source); };

            var promise = postUpdate(self.newPostText()).pipe(function (result) {
                var mapper = new activityFeed.UpdatesMapper(options.user, removeUpdate);
                var update = mapper.mapUpdateToUpdateViewModel(result.value);
                self.updates.unshift(update);
                self.newPostText("");

                return update;
            });

            return promise;
        }, self.newPostText);


    this.searchTerm = ko.observable("");
    this.throttledSearchTerm = ko.computed(this.searchTerm).extend({ throttle: 400 });
    this.throttledSearchTerm.subscribe(function (val) {
        self.searchUpdates();
    }, this);

    var searchInternal = function () {
            var promise = activityFeed.api.getUpdates(options.topic, self.searchTerm(), null, options.pageSize).pipe(function (result) {
                self.hasMoreUpdates(!result.complete);
                self.updates(updatesMapper.mapUpdates(result.value));
            });
            return promise;
        };

    this.refreshUpdates = ko.asyncCommand(
        function () {
            self.searchTerm("");
            return searchInternal();
        });

    this.searchUpdates = ko.asyncCommand(function () {
        return searchInternal();
    }, /*self.searchTerm*/null);

    this.readMoreUpdates = ko.asyncCommand(
        function () {
            var updatesCount = self.updates().length;
            var lastUpdateDate = updatesCount > 0 ? self.updates()[updatesCount - 1].publishedOn().toISOString() : null;

            var promise = activityFeed.api.getUpdates(options.topic, self.searchTerm(), lastUpdateDate, options.pageSize).pipe(function (result) {
                var newUpdates = updatesMapper.mapUpdates(result.value);
                self.hasMoreUpdates(!result.complete);
                for (var i = 0, length = newUpdates.length; i < length; i++) {
                    self.updates.push(newUpdates[i]);
                }
            });
            return promise;
        });

    this.hasMoreUpdates = ko.observable(!options.isListComplete);

    this.contentTemplateExists = function (update) {
        return !!options.updateContentTemplates[update.contentType()];
    };

    this.getUpdateContentTemplate = function (update) {
        var updateContentTemplate = options.updateContentTemplates[update.contentType()];
        if (updateContentTemplate == null) {
            throw "Cannot find update content template: " + updateContentTemplate;
        }
        return updateContentTemplate;
    };
};
activityFeed.CommentViewModel = function (currenctUser, removeCommentHandler) {
    var self = this;

    this.id = ko.observable();
    this.text = ko.observable();
    this.publisher = ko.observable();
    this.publishedOn = ko.observable(new Date());

    this.isAllowed = ko.computed(function () { return !!currenctUser && !!self.publisher() && self.publisher().id == currenctUser.id; });

    this.isEditable = ko.computed(function () { return !!self.id() && self.isAllowed(); });
    

    this.removeComment = ko.asyncCommand(
        function () {
            return removeCommentHandler(self);
        }, self.isEditable, self.isAllowed);
};
activityFeed.UpdateViewModel = function (currenctUser, removeUpdateHandler) {
    var self = this;

    this.id = ko.observable();
    this.contentType = ko.observable();
    this.content = ko.observable();
    this.publisher = ko.observable();
    this.source = ko.observable();
    this.publishedOn = ko.observable(new Date());

    this.isEditable = ko.computed(function () {
        return !!self.id() && !!self.publisher() && self.publisher().id == currenctUser.id;
    });

    this.removeUpdate = ko.asyncCommand(
      function () {
          return removeUpdateHandler(self);
      }, null, self.isEditable);



    // comments
    this.comments = ko.observableArray();
    this.hasComments = ko.computed(function () {
        return self.comments.length > 0;
    });

    this.newCommentText = ko.observable();

    this.postNewComment = ko.asyncCommand(
        function () {
            var promise = activityFeed.api.postComment(self.id(), self.newCommentText()).pipe(function (result) {
                var mapper = new activityFeed.UpdatesMapper(currenctUser);
                var comment = mapper.mapCommentToCommentViewModel(result.value, self);
                self.comments.push(comment);

                self.newCommentText("");

                return comment;
            });

            return promise;
        }, self.newCommentText);

    this.removeCommentHandler = function (comment) {
        return activityFeed.api.removeComment(self.id(), comment.id()).pipe(function () {
            self.comments.remove(comment);
        });
    };

    this.isCommentBoxVisible = ko.observable(false);

    this.showHideComments = function () {
        self.isCommentBoxVisible(!self.isCommentBoxVisible());
    };




    // likes
    this.likes = ko.observableArray();

    var getCurrentUserLike = function () {
        var length = self.likes().length;
        for (var i = 0; i < length; i++) {
            var user = self.likes()[i].user();
            if (user && user.id == currenctUser.id) {
                return self.likes()[i];
            }
        }
        return null;
    };

    this.hasLikes = ko.computed(function () { return !!self.likes().length; }, this);

    this.likesExcludingMine = ko.computed(function () {
        var result = new Array();
        for (var i = 0, length = self.likes().length; i < length; i++) {
            var like = self.likes()[i];
            if (like.user() && currenctUser.id != like.user().id) {
                result.push(like);
            }
        }
        return result;
    }, this);

    this.likedByMe = ko.computed(function () {
        var currentUserLike = getCurrentUserLike();
        return !!currentUserLike;
    }, this);

    this.toggleLike = ko.asyncCommand(
        function () {
            if (self.likedByMe()) {
                return removeLike();
            } else {
                return addLike();
            }
        }, self.id);

    var addLike = function () {
        var promise = activityFeed.api.likeUpdate(self.id()).pipe(function (result) {
            var mapper = new activityFeed.UpdatesMapper(currenctUser);
            var like = mapper.mapLikeToLikeViewModel(result.value);
            self.likes.push(like);
        });

        return promise;
    };

    var removeLike = function () {
        var promise = activityFeed.api.removeLikeFromUpdate(self.id()).pipe(function () {
            var currentUserLike = getCurrentUserLike();
            self.likes.remove(currentUserLike);
        });

        return promise;
    };
};

