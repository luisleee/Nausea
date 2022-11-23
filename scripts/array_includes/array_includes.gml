function array_includes(arr, element) {
    var len = array_length(arr);
    for (i = 0; i < len; i++) { 
        if (element == arr[i]) {
            return true;
        }
    }
    return false;
}