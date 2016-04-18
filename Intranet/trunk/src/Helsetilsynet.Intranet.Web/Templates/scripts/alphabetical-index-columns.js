(function (a) {
    a.fn.splitToColumns = function (columnCount) {
        this.each(function () {
            var childCount, children, itemsPerColumn, columns = [], i, aThis;
            children = a(this).children();
            childCount = children.length;
            aThis = a(this);
            itemsPerColumn = Math.ceil(childCount / columnCount);
            for(i = 0; i < columnCount; i += 1) {
                column = a('<div class="column" />');
                column.append(aThis.children().slice(0, itemsPerColumn));
                columns.push(column);
            }
            while(columns.length > 0) {
                aThis.prepend(columns.pop());
            }
        });
    }
})(jQuery);
