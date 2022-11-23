function is_punctuation(ch) {
    var punctuations = ["。","，","！","？","…","—","》","）","”","：","；"," "];
    return array_includes(punctuations, ch);
}