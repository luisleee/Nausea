/// @desc Check if an element is in the array
/// @param {array} arr Target array
/// @param {any*} element Target element
/// @returns {bool} Array includes the element or not
function array_includes(arr, element) {
    var len = array_length(arr);
    for (i = 0; i < len; i++) { 
        if (element == arr[i]) {
            return true;
        }
    }
    return false;
}