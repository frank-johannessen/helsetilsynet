var custom_validators = {

    //Checks whether any of the two dropdowns passed have any value selected other than 0 element
    validateTwoDropDownLists: function (firstDropDownId, secondDropDownId) {
        var firstDropDown = document.getElementById(firstDropDownId);
        var secondDropDown = document.getElementById(secondDropDownId);

        if (firstDropDown === undefined || secondDropDown === undefined)
            return false;

        if (firstDropDown.selectedIndex === 0 && secondDropDown.selectedIndex === 0)
            return false;

        if (firstDropDown.selectedIndex !== 0 && secondDropDown.selectedIndex !== 0)
            return false;
        
        return true;
    }
}