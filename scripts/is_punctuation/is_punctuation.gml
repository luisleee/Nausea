/// @desc Checks whether a character is a punctuation or not
/// @param {any*} ch The character
/// @returns {bool} The result
function is_punctuation(ch) {
    var punctuations = ["。","，","！","？","…","—","》","）","”","：","；"," "];
    return array_includes(punctuations, ch);
}