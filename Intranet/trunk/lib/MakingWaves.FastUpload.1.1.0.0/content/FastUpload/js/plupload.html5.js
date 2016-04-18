(function(h, k, j, e) {
    var c = { }, g;

    function m(o, p) {
        var n;
        if ("FileReader" in h) {
            n = new FileReader();
            n.readAsDataURL(o);
            n.onload = function() { p(n.result); };
        } else {
            return p(o.getAsDataURL());
        }
    }

    function l(o, p) {
        var n;
        if ("FileReader" in h) {
            n = new FileReader();
            n.readAsBinaryString(o);
            n.onload = function() { p(n.result); };
        } else {
            return p(o.getAsBinary());
        }
    }

    function d(r, p, n, v) {
        var q, o, u, s, t = this;
        m(c[r.id], function(w) {
            q = k.createElement("canvas");
            q.style.display = "none";
            k.body.appendChild(q);
            o = q.getContext("2d");
            u = new Image();
            u.onerror = u.onabort = function() { v({ success: false }); };
            u.onload = function() {
                var B, x, z, y, A;
                if (!p.width) {
                    p.width = u.width;
                }
                if (!p.height) {
                    p.height = u.height;
                }
                s = Math.min(p.width / u.width, p.height / u.height);
                if (s < 1 || (s === 1 && n === "image/jpeg")) {
                    B = Math.round(u.width * s);
                    x = Math.round(u.height * s);
                    q.width = B;
                    q.height = x;
                    o.drawImage(u, 0, 0, B, x);
                    if (n === "image/jpeg") {
                        y = new f(atob(w.substring(w.indexOf("base64,") + 7)));
                        if (y.headers && y.headers.length) {
                            A = new a();
                            if (A.init(y.get("exif")[0])) {
                                A.setExif("PixelXDimension", B);
                                A.setExif("PixelYDimension", x);
                                y.set("exif", A.getBinary());
                                if (t.hasEventListener("ExifData")) {
                                    t.trigger("ExifData", r, A.EXIF());
                                }
                                if (t.hasEventListener("GpsData")) {
                                    t.trigger("GpsData", r, A.GPS());
                                }
                            }
                        }
                        if (p.quality) {
                            try {
                                w = q.toDataURL(n, p.quality / 100);
                            } catch(C) {
                                w = q.toDataURL(n);
                            }
                        }
                    } else {
                        w = q.toDataURL(n);
                    }
                    w = w.substring(w.indexOf("base64,") + 7);
                    w = atob(w);
                    if (y && y.headers && y.headers.length) {
                        w = y.restore(w);
                        y.purge();
                    }
                    q.parentNode.removeChild(q);
                    v({ success: true, data: w });
                } else {
                    v({ success: false });
                }
            };
            u.src = w;
        });
    }

    j.runtimes.Html5 = j.addRuntime("html5", {
        getFeatures: function() {
            var s, o, r, q, p, n;
            o = r = p = n = false;
            if (h.XMLHttpRequest) {
                s = new XMLHttpRequest();
                r = !!s.upload;
                o = !!(s.sendAsBinary || s.upload);
            }
            if (o) {
                q = !!(s.sendAsBinary || (h.Uint8Array && h.ArrayBuffer));
                p = !!(File && (File.prototype.getAsDataURL || h.FileReader) && q);
                n = !!(File && (File.prototype.mozSlice || File.prototype.webkitSlice || File.prototype.slice));
            }
            g = j.ua.safari && j.ua.windows;
            return {
                html5: o,
                dragdrop: (function() {
                    var t = k.createElement("div");
                    return ("draggable" in t) || ("ondragstart" in t && "ondrop" in t);
                }()),
                jpgresize: p,
                pngresize: p,
                multipart: p || !!h.FileReader || !!h.FormData,
                canSendBinary: q,
                cantSendBlobInFormData: !!(j.ua.gecko && h.FormData && h.FileReader && !FileReader.prototype.readAsArrayBuffer),
                progress: r,
                chunks: n,
                multi_selection: !(j.ua.safari && j.ua.windows),
                triggerDialog: (j.ua.gecko && h.FormData || j.ua.webkit)
            };
        },
        init: function(p, q) {
            var n;

            function o(v) {
                var t, s, u = [], w, r = { };
                for (s = 0; s < v.length; s++) {
                    t = v[s];
                    if (r[t.name]) {
                        continue;
                    }
                    r[t.name] = true;
                    w = j.guid();
                    c[w] = t;
                    u.push(new j.File(w, t.fileName || t.name, t.fileSize || t.size));
                }
                if (u.length) {
                    p.trigger("FilesAdded", u);
                }
            }

            n = this.getFeatures();
            if (!n.html5) {
                q({ success: false });
                return;
            }
            p.bind("Init", function(v) {
                var F, E, B = [], u, C, s = v.settings.filters, t, A, r = k.body, D;
                F = k.createElement("div");
                F.id = v.id + "_html5_container";
                j.extend(F.style, { position: "absolute", background: p.settings.shim_bgcolor || "transparent", width: "100px", height: "100px", overflow: "hidden", zIndex: 99999, opacity: p.settings.shim_bgcolor ? "" : 0 });
                F.className = "plupload html5";
                if (p.settings.container) {
                    r = k.getElementById(p.settings.container);
                    if (j.getStyle(r, "position") === "static") {
                        r.style.position = "relative";
                    }
                }
                r.appendChild(F);
                no_type_restriction:for (u = 0; u < s.length; u++) {
                                        t = s[u].extensions.split( /,/ );
                                        for (C = 0; C < t.length; C++) {
                                            if (t[C] === "*") {
                                                B = [];
                                                break no_type_restriction;
                                            }
                                            A = j.mimeTypes[t[C]];
                                            if (A) {
                                                B.push(A);
                                            }
                                        }
                                    }
                F.innerHTML = '<input id="' + p.id + '_html5"  style="font-size:999px" type="file" accept="' + B.join(",") + '" ' + (p.settings.multi_selection && p.features.multi_selection ? 'multiple="multiple"' : "") + " />";
                F.scrollTop = 100;
                D = k.getElementById(p.id + "_html5");
                if (v.features.triggerDialog) {
                    j.extend(D.style, { position: "absolute", width: "100%", height: "100%" });
                } else {
                    j.extend(D.style, { cssFloat: "right", styleFloat: "right" });
                }
                D.onchange = function() {
                    o(this.files);
                    this.value = "";
                };
                E = k.getElementById(v.settings.browse_button);
                if (E) {
                    var x = v.settings.browse_button_hover, z = v.settings.browse_button_active, w = v.features.triggerDialog ? E : F;
                    if (x) {
                        j.addEvent(w, "mouseover", function() { j.addClass(E, x); }, v.id);
                        j.addEvent(w, "mouseout", function() { j.removeClass(E, x); }, v.id);
                    }
                    if (z) {
                        j.addEvent(w, "mousedown", function() { j.addClass(E, z); }, v.id);
                        j.addEvent(k.body, "mouseup", function() { j.removeClass(E, z); }, v.id);
                    }
                    if (v.features.triggerDialog) {
                        j.addEvent(E, "click", function(y) {
                            k.getElementById(v.id + "_html5").click();
                            y.preventDefault();
                        }, v.id);
                    }
                }
            });
            p.bind("PostInit", function() {
                var r = k.getElementById(p.settings.drop_element);
                if (r) {
                    if (g) {
                        j.addEvent(r, "dragenter", function(v) {
                            var u, s, t;
                            u = k.getElementById(p.id + "_drop");
                            if (!u) {
                                u = k.createElement("input");
                                u.setAttribute("type", "file");
                                u.setAttribute("id", p.id + "_drop");
                                u.setAttribute("multiple", "multiple");
                                j.addEvent(u, "change", function() {
                                    o(this.files);
                                    j.removeEvent(u, "change", p.id);
                                    u.parentNode.removeChild(u);
                                }, p.id);
                                r.appendChild(u);
                            }
                            s = j.getPos(r, k.getElementById(p.settings.container));
                            t = j.getSize(r);
                            if (j.getStyle(r, "position") === "static") {
                                j.extend(r.style, { position: "relative" });
                            }
                            j.extend(u.style, { position: "absolute", display: "block", top: 0, left: 0, width: t.w + "px", height: t.h + "px", opacity: 0 });
                        }, p.id);
                        return;
                    }
                    j.addEvent(r, "dragover", function(s) { s.preventDefault(); }, p.id);
                    j.addEvent(r, "drop", function(t) {
                        var s = t.dataTransfer;
                        if (s && s.files) {
                            o(s.files);
                        }
                        t.preventDefault();
                    }, p.id);
                }
            });
            p.bind("Refresh", function(r) {
                var s, t, u, w, v;
                s = k.getElementById(p.settings.browse_button);
                if (s) {
                    t = j.getPos(s, k.getElementById(r.settings.container));
                    u = j.getSize(s);
                    w = k.getElementById(p.id + "_html5_container");
                    j.extend(w.style, { top: t.y + "px", left: t.x + "px", width: u.w + "px", height: u.h + "px" });
                    if (p.features.triggerDialog) {
                        if (j.getStyle(s, "position") === "static") {
                            j.extend(s.style, { position: "relative" });
                        }
                        v = parseInt(j.getStyle(s, "z-index"), 10);
                        if (isNaN(v)) {
                            v = 0;
                        }
                        j.extend(s.style, { zIndex: v });
                        j.extend(w.style, { zIndex: v - 1 });
                    }
                }
            });
            p.bind("UploadFile", function(r, t) {
                var u = r.settings, x, s;

                function w(z, C, y) {
                    var A;
                    if (File.prototype.slice) {
                        try {
                            z.slice();
                            return z.slice(C, y);
                        } catch(B) {
                            return z.slice(C, y - C);
                        }
                    } else {
                        if (A = File.prototype.webkitSlice || File.prototype.mozSlice) {
                            return A.call(z, C, y);
                        } else {
                            return null;
                        }
                    }
                }

                function v(z) {
                    var C = 0, B = 0, y = ("FileReader" in h) ? new FileReader : null;

                    function A() {
                        var H, L, J, K, G, I, E, D = r.settings.url;

                        function F(V) {
                            var S = 0, T = new XMLHttpRequest, W = T.upload, M = "----pluploadboundary" + j.guid(), N, O = "--", U = "\r\n", Q = "";
                            if (W) {
                                W.onprogress = function(X) {
                                    t.loaded = Math.min(t.size, B + X.loaded - S);
                                    r.trigger("UploadProgress", t);
                                };
                            }
                            T.onreadystatechange = function() {
                                var X, Z;
                                if (T.readyState == 4) {
                                    try {
                                        X = T.status;
                                    } catch(Y) {
                                        X = 0;
                                    }
                                    if (X >= 400) {
                                        r.trigger("Error", { code: j.HTTP_ERROR, message: j.translate("HTTP Error."), file: t, status: X });
                                    } else {
                                        if (J) {
                                            Z = { chunk: C, chunks: J, response: T.responseText, status: X };
                                            r.trigger("ChunkUploaded", t, Z);
                                            B += I;
                                            if (Z.cancelled) {
                                                t.status = j.FAILED;
                                                return;
                                            }
                                            t.loaded = Math.min(t.size, (C + 1) * G);
                                        } else {
                                            t.loaded = t.size;
                                        }
                                        r.trigger("UploadProgress", t);
                                        V = H = N = Q = null;
                                        if (!J || ++C >= J) {
                                            t.status = j.DONE;
                                            r.trigger("FileUploaded", t, { response: T.responseText, status: X });
                                        } else {
                                            A();
                                        }
                                    }
                                    T = null;
                                }
                            };
                            if (r.settings.multipart && n.multipart) {
                                K.name = t.target_name || t.name;
                                T.open("post", D, true);
                                j.each(r.settings.headers, function(Y, X) { T.setRequestHeader(X, Y); });
                                if (typeof(V) !== "string" && !!h.FormData) {
                                    N = new FormData();
                                    j.each(j.extend(K, r.settings.multipart_params), function(Y, X) { N.append(X, Y); });
                                    N.append(r.settings.file_data_name, V);
                                    T.send(N);
                                    return;
                                }
                                if (typeof(V) === "string") {
                                    T.setRequestHeader("Content-Type", "multipart/form-data; boundary=" + M);
                                    j.each(j.extend(K, r.settings.multipart_params), function(Y, X) {
                                        Q += O + M + U + 'Content-Disposition: form-data; name="' + X + '"' + U + U;
                                        Q += unescape(encodeURIComponent(Y)) + U;
                                    });
                                    E = j.mimeTypes[t.name.replace( /^.+\.([^.]+)/ , "$1").toLowerCase()] || "application/octet-stream";
                                    Q += O + M + U + 'Content-Disposition: form-data; name="' + r.settings.file_data_name + '"; filename="' + unescape(encodeURIComponent(t.name)) + '"' + U + "Content-Type: " + E + U + U + V + U + O + M + O + U;
                                    S = Q.length - V.length;
                                    V = Q;
                                    if (T.sendAsBinary) {
                                        T.sendAsBinary(V);
                                    } else {
                                        if (n.canSendBinary) {
                                            var R = new Uint8Array(V.length);
                                            for (var P = 0; P < V.length; P++) {
                                                R[P] = (V.charCodeAt(P) & 255);
                                            }
                                            T.send(R.buffer);
                                        }
                                    }
                                    return;
                                }
                            }
                            D = j.buildUrl(r.settings.url, j.extend(K, r.settings.multipart_params));
                            T.open("post", D, true);
                            T.setRequestHeader("Content-Type", "application/octet-stream");
                            j.each(r.settings.headers, function(Y, X) { T.setRequestHeader(X, Y); });
                            T.send(V);
                        }

                        if (t.status == j.DONE || t.status == j.FAILED || r.state == j.STOPPED) {
                            return;
                        }
                        K = { name: t.target_name || t.name };
                        if (u.chunk_size && t.size > u.chunk_size && (n.chunks || typeof(z) == "string")) {
                            G = u.chunk_size;
                            J = Math.ceil(t.size / G);
                            I = Math.min(G, t.size - (C * G));
                            if (typeof(z) == "string") {
                                H = z.substring(C * G, C * G + I);
                            } else {
                                H = w(z, C * G, C * G + I);
                            }
                            K.chunk = C;
                            K.chunks = J;
                        } else {
                            I = t.size;
                            H = z;
                        }
                        if (typeof(H) !== "string" && y && n.cantSendBlobInFormData && n.chunks && r.settings.chunk_size) {
                            y.onload = function() { F(y.result); };
                            y.readAsBinaryString(H);
                        } else {
                            F(H);
                        }
                    }

                    A();
                }

                x = c[t.id];
                if (n.jpgresize && r.settings.resize && /\.(png|jpg|jpeg)$/i .test(t.name)) {
                    d.call(r, t, r.settings.resize, /\.png$/i .test(t.name) ? "image/png" : "image/jpeg", function(y) {
                        if (y.success) {
                            t.size = y.data.length;
                            v(y.data);
                        } else {
                            v(x);
                        }
                    });
                } else {
                    if (!n.chunks && n.jpgresize) {
                        l(x, v);
                    } else {
                        v(x);
                    }
                }
            });
            p.bind("Destroy", function(r) {
                var t, u, s = k.body, v = { inputContainer: r.id + "_html5_container", inputFile: r.id + "_html5", browseButton: r.settings.browse_button, dropElm: r.settings.drop_element };
                for (t in v) {
                    u = k.getElementById(v[t]);
                    if (u) {
                        j.removeAllEvents(u, r.id);
                    }
                }
                j.removeAllEvents(k.body, r.id);
                if (r.settings.container) {
                    s = k.getElementById(r.settings.container);
                }
                s.removeChild(k.getElementById(v.inputContainer));
            });
            q({ success: true });
        }
    });

    function b() {
        var q = false, o;

        function r(t, v) {
            var s = q ? 0 : -8 * (v - 1), w = 0, u;
            for (u = 0; u < v; u++) {
                w |= (o.charCodeAt(t + u) << Math.abs(s + u * 8));
            }
            return w;
        }

        function n(u, s, t) {
            var t = arguments.length === 3 ? t : o.length - s - 1;
            o = o.substr(0, s) + u + o.substr(t + s);
        }

        function p(t, u, w) {
            var x = "", s = q ? 0 : -8 * (w - 1), v;
            for (v = 0; v < w; v++) {
                x += String.fromCharCode((u >> Math.abs(s + v * 8)) & 255);
            }
            n(x, t, w);
        }

        return {
            II: function(s) {
                if (s === e) {
                    return q;
                } else {
                    q = s;
                }
            },
            init: function(s) {
                q = false;
                o = s;
            },
            SEGMENT: function(s, u, t) {
                switch (arguments.length) {
                case 1:
                    return o.substr(s, o.length - s - 1);
                case 2:
                    return o.substr(s, u);
                case 3:
                    n(t, s, u);
                    break;
                default:
                    return o;
                }
            },
            BYTE: function(s) { return r(s, 1); },
            SHORT: function(s) { return r(s, 2); },
            LONG: function(s, t) {
                if (t === e) {
                    return r(s, 4);
                } else {
                    p(s, t, 4);
                }
            },
            SLONG: function(s) {
                var t = r(s, 4);
                return (t > 2147483647 ? t - 4294967296 : t);
            },
            STRING: function(s, t) {
                var u = "";
                for (t += s; s < t; s++) {
                    u += String.fromCharCode(r(s, 1));
                }
                return u;
            }
        };
    }

    function f(s) {
        var u = { 65505: { app: "EXIF", name: "APP1", signature: "Exif\0" }, 65506: { app: "ICC", name: "APP2", signature: "ICC_PROFILE\0" }, 65517: { app: "IPTC", name: "APP13", signature: "Photoshop 3.0\0" } }, t = [], r, n, p = e, q = 0, o;
        r = new b();
        r.init(s);
        if (r.SHORT(0) !== 65496) {
            return;
        }
        n = 2;
        o = Math.min(1048576, s.length);
        while (n <= o) {
            p = r.SHORT(n);
            if (p >= 65488 && p <= 65495) {
                n += 2;
                continue;
            }
            if (p === 65498 || p === 65497) {
                break;
            }
            q = r.SHORT(n + 2) + 2;
            if (u[p] && r.STRING(n + 4, u[p].signature.length) === u[p].signature) {
                t.push({ hex: p, app: u[p].app.toUpperCase(), name: u[p].name.toUpperCase(), start: n, length: q, segment: r.SEGMENT(n, q) });
            }
            n += q;
        }
        r.init(null);
        return {
            headers: t,
            restore: function(y) {
                r.init(y);
                var w = new f(y);
                if (!w.headers) {
                    return false;
                }
                for (var x = w.headers.length; x > 0; x--) {
                    var z = w.headers[x - 1];
                    r.SEGMENT(z.start, z.length, "");
                }
                w.purge();
                n = r.SHORT(2) == 65504 ? 4 + r.SHORT(4) : 2;
                for (var x = 0, v = t.length; x < v; x++) {
                    r.SEGMENT(n, 0, t[x].segment);
                    n += t[x].length;
                }
                return r.SEGMENT();
            },
            get: function(x) {
                var y = [];
                for (var w = 0, v = t.length; w < v; w++) {
                    if (t[w].app === x.toUpperCase()) {
                        y.push(t[w].segment);
                    }
                }
                return y;
            },
            set: function(y, x) {
                var z = [];
                if (typeof(x) === "string") {
                    z.push(x);
                } else {
                    z = x;
                }
                for (var w = ii = 0, v = t.length; w < v; w++) {
                    if (t[w].app === y.toUpperCase()) {
                        t[w].segment = z[ii];
                        t[w].length = z[ii].length;
                        ii++;
                    }
                    if (ii >= z.length) {
                        break;
                    }
                }
            },
            purge: function() {
                t = [];
                r.init(null);
            }
        };
    }

    function a() {
        var q, n, o = { }, t;
        q = new b();
        n = { tiff: { 274: "Orientation", 34665: "ExifIFDPointer", 34853: "GPSInfoIFDPointer" }, exif: { 36864: "ExifVersion", 40961: "ColorSpace", 40962: "PixelXDimension", 40963: "PixelYDimension", 36867: "DateTimeOriginal", 33434: "ExposureTime", 33437: "FNumber", 34855: "ISOSpeedRatings", 37377: "ShutterSpeedValue", 37378: "ApertureValue", 37383: "MeteringMode", 37384: "LightSource", 37385: "Flash", 41986: "ExposureMode", 41987: "WhiteBalance", 41990: "SceneCaptureType", 41988: "DigitalZoomRatio", 41992: "Contrast", 41993: "Saturation", 41994: "Sharpness" }, gps: { 0: "GPSVersionID", 1: "GPSLatitudeRef", 2: "GPSLatitude", 3: "GPSLongitudeRef", 4: "GPSLongitude" } };
        t = { ColorSpace: { 1: "sRGB", 0: "Uncalibrated" }, MeteringMode: { 0: "Unknown", 1: "Average", 2: "CenterWeightedAverage", 3: "Spot", 4: "MultiSpot", 5: "Pattern", 6: "Partial", 255: "Other" }, LightSource: { 1: "Daylight", 2: "Fliorescent", 3: "Tungsten", 4: "Flash", 9: "Fine weather", 10: "Cloudy weather", 11: "Shade", 12: "Daylight fluorescent (D 5700 - 7100K)", 13: "Day white fluorescent (N 4600 -5400K)", 14: "Cool white fluorescent (W 3900 - 4500K)", 15: "White fluorescent (WW 3200 - 3700K)", 17: "Standard light A", 18: "Standard light B", 19: "Standard light C", 20: "D55", 21: "D65", 22: "D75", 23: "D50", 24: "ISO studio tungsten", 255: "Other" }, Flash: { 0: "Flash did not fire.", 1: "Flash fired.", 5: "Strobe return light not detected.", 7: "Strobe return light detected.", 9: "Flash fired, compulsory flash mode", 13: "Flash fired, compulsory flash mode, return light not detected", 15: "Flash fired, compulsory flash mode, return light detected", 16: "Flash did not fire, compulsory flash mode", 24: "Flash did not fire, auto mode", 25: "Flash fired, auto mode", 29: "Flash fired, auto mode, return light not detected", 31: "Flash fired, auto mode, return light detected", 32: "No flash function", 65: "Flash fired, red-eye reduction mode", 69: "Flash fired, red-eye reduction mode, return light not detected", 71: "Flash fired, red-eye reduction mode, return light detected", 73: "Flash fired, compulsory flash mode, red-eye reduction mode", 77: "Flash fired, compulsory flash mode, red-eye reduction mode, return light not detected", 79: "Flash fired, compulsory flash mode, red-eye reduction mode, return light detected", 89: "Flash fired, auto mode, red-eye reduction mode", 93: "Flash fired, auto mode, return light not detected, red-eye reduction mode", 95: "Flash fired, auto mode, return light detected, red-eye reduction mode" }, ExposureMode: { 0: "Auto exposure", 1: "Manual exposure", 2: "Auto bracket" }, WhiteBalance: { 0: "Auto white balance", 1: "Manual white balance" }, SceneCaptureType: { 0: "Standard", 1: "Landscape", 2: "Portrait", 3: "Night scene" }, Contrast: { 0: "Normal", 1: "Soft", 2: "Hard" }, Saturation: { 0: "Normal", 1: "Low saturation", 2: "High saturation" }, Sharpness: { 0: "Normal", 1: "Soft", 2: "Hard" }, GPSLatitudeRef: { N: "North latitude", S: "South latitude" }, GPSLongitudeRef: { E: "East longitude", W: "West longitude" } };

        function p(u, C) {
            var w = q.SHORT(u), z, F, G, B, A, v, x, D, E = [], y = { };
            for (z = 0; z < w; z++) {
                x = v = u + 12 * z + 2;
                G = C[q.SHORT(x)];
                if (G === e) {
                    continue;
                }
                B = q.SHORT(x += 2);
                A = q.LONG(x += 2);
                x += 4;
                E = [];
                switch (B) {
                case 1:
                case 7:
                    if (A > 4) {
                        x = q.LONG(x) + o.tiffHeader;
                    }
                    for (F = 0; F < A; F++) {
                        E[F] = q.BYTE(x + F);
                    }
                    break;
                case 2:
                    if (A > 4) {
                        x = q.LONG(x) + o.tiffHeader;
                    }
                    y[G] = q.STRING(x, A - 1);
                    continue;
                case 3:
                    if (A > 2) {
                        x = q.LONG(x) + o.tiffHeader;
                    }
                    for (F = 0; F < A; F++) {
                        E[F] = q.SHORT(x + F * 2);
                    }
                    break;
                case 4:
                    if (A > 1) {
                        x = q.LONG(x) + o.tiffHeader;
                    }
                    for (F = 0; F < A; F++) {
                        E[F] = q.LONG(x + F * 4);
                    }
                    break;
                case 5:
                    x = q.LONG(x) + o.tiffHeader;
                    for (F = 0; F < A; F++) {
                        E[F] = q.LONG(x + F * 4) / q.LONG(x + F * 4 + 4);
                    }
                    break;
                case 9:
                    x = q.LONG(x) + o.tiffHeader;
                    for (F = 0; F < A; F++) {
                        E[F] = q.SLONG(x + F * 4);
                    }
                    break;
                case 10:
                    x = q.LONG(x) + o.tiffHeader;
                    for (F = 0; F < A; F++) {
                        E[F] = q.SLONG(x + F * 4) / q.SLONG(x + F * 4 + 4);
                    }
                    break;
                default:
                    continue;
                }
                D = (A == 1 ? E[0] : E);
                if (t.hasOwnProperty(G) && typeof D != "object") {
                    y[G] = t[G][D];
                } else {
                    y[G] = D;
                }
            }
            return y;
        }

        function s() {
            var v = e, u = o.tiffHeader;
            q.II(q.SHORT(u) == 18761);
            if (q.SHORT(u += 2) !== 42) {
                return false;
            }
            o.IFD0 = o.tiffHeader + q.LONG(u += 2);
            v = p(o.IFD0, n.tiff);
            o.exifIFD = ("ExifIFDPointer" in v ? o.tiffHeader + v.ExifIFDPointer : e);
            o.gpsIFD = ("GPSInfoIFDPointer" in v ? o.tiffHeader + v.GPSInfoIFDPointer : e);
            return true;
        }

        function r(w, u, z) {
            var B, y, x, A = 0;
            if (typeof(u) === "string") {
                var v = n[w.toLowerCase()];
                for (hex in v) {
                    if (v[hex] === u) {
                        u = hex;
                        break;
                    }
                }
            }
            B = o[w.toLowerCase() + "IFD"];
            y = q.SHORT(B);
            for (i = 0; i < y; i++) {
                x = B + 12 * i + 2;
                if (q.SHORT(x) == u) {
                    A = x + 8;
                    break;
                }
            }
            if (!A) {
                return false;
            }
            q.LONG(A, z);
            return true;
        }

        return {
            init: function(u) {
                o = { tiffHeader: 10 };
                if (u === e || !u.length) {
                    return false;
                }
                q.init(u);
                if (q.SHORT(0) === 65505 && q.STRING(4, 5).toUpperCase() === "EXIF\0") {
                    return s();
                }
                return false;
            },
            EXIF: function() {
                var u;
                u = p(o.exifIFD, n.exif);
                if (u.ExifVersion) {
                    u.ExifVersion = String.fromCharCode(u.ExifVersion[0], u.ExifVersion[1], u.ExifVersion[2], u.ExifVersion[3]);
                }
                return u;
            },
            GPS: function() {
                var u;
                u = p(o.gpsIFD, n.gps);
                if (u.GPSVersionID) {
                    u.GPSVersionID = u.GPSVersionID.join(".");
                }
                return u;
            },
            setExif: function(u, v) {
                if (u !== "PixelXDimension" && u !== "PixelYDimension") {
                    return false;
                }
                return r("exif", u, v);
            },
            getBinary: function() { return q.SEGMENT(); }
        };
    }
})(window, document, plupload);