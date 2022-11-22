// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_includes(arr, element) {
    var len = array_length(arr);
    for (i = 0; i < len; i++) { 
        if (element == arr[i]) {
            return true;
        }
    }
    return false;
}