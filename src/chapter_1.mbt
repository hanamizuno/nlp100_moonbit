/// https://nlp100.github.io/2025/ja/ch01.html

///|
/// メソッドチェーンを使う
///
/// ```mbt check
/// test {
///   inspect(e_00(), content="パタトクカシーー")
/// }
/// ```
pub fn e_00() -> String {
  let word_1 : String = "パトカー"
  let word_2 : String = "タクシー"
  word_1
  .to_array()
  .zip(word_2.to_array())
  /// `(a, b) => a + b` みたいな書き方はできない
  .map(pair => String::from_array([pair.0, pair.1]))
  .join("")
}

///|
/// パイプライン演算子を使う
///
/// ```mbt check
/// test {
///   inspect(e_00_2(), content="パタトクカシーー")
/// }
/// ```
pub fn e_00_2() -> String {
  let word_1 : String = "パトカー"
  let word_2 : String = "タクシー"
  word_1
  |> String::to_array()
  |> Array::zip(word_2.to_array())
  |> Array::map(pair => String::from_array([pair.0, pair.1]))
  |> Array::join("")
}

///|
/// zipをmatchと再帰で実装してみる
///
/// ```mbt check
/// test {
///   inspect(e_00_3(), content="パタトクカシーー")
/// }
/// ```
pub fn e_00_3() -> String {
  let word_1 : String = "パトカー"
  let word_2 : String = "タクシー"

  /// ローカル関数の定義には型引数を使えないので、Charに固定
  fn zip(a : Array[Char], b : Array[Char]) -> Array[(Char, Char)] {
    match (a, b) {
      ([], _) => []
      (_, []) => []
      ([hd_a, .. tl_a], [hd_b, .. tl_b]) =>
        [(hd_a, hd_b)] + zip(tl_a.to_owned(), tl_b.to_owned())
    }
  }

  zip(word_1.to_array(), word_2.to_array())
  |> Array::map(pair => String::from_array([pair.0, pair.1]))
  |> Array::join("")
}

///|
/// 型引数の使用例
pub fn[A, B] zip_(a : Array[A], b : Array[B]) -> Array[(A, B)] {
  match (a, b) {
    ([], _) => []
    (_, []) => []
    ([hd_a, .. tl_a], [hd_b, .. tl_b]) =>
      [(hd_a, hd_b)] + zip_(tl_a.to_owned(), tl_b.to_owned())
  }
}

///|
/// forループを使う
///
/// ```mbt check
/// test {
///   inspect(e_00_4(), content="パタトクカシーー")
/// }
/// ```
pub fn e_00_4() -> String {
  let word_1 : String = "パトカー"
  let word_2 : String = "タクシー"
  let length = if word_1.length() < word_2.length() {
    word_1.length()
  } else {
    word_2.length()
  }

  /// String[i]はCharではなくUInt16を返すので、まずArray[Char]に変換する
  let word_1_arr = word_1.to_array()
  let word_2_arr = word_2.to_array()
  let result_array : Array[String] = []
  for i in 0..<length {
    result_array.push(String::from_array([word_1_arr[i], word_2_arr[i]]))
  }
  result_array.join("")
}

///|
/// mutableな変数とテンプレートリテラルを使う
///
/// ```mbt check
/// test {
///   inspect(e_00_5(), content="パタトクカシーー")
/// }
/// ```
pub fn e_00_5() -> String {
  let word_1 : String = "パトカー"
  let word_2 : String = "タクシー"
  let length = if word_1.length() < word_2.length() {
    word_1.length()
  } else {
    word_2.length()
  }

  /// String[i]はCharではなくUInt16を返すので、まずArray[Char]に変換する
  let word_1_arr = word_1.to_array()
  let word_2_arr = word_2.to_array()
  /// mutableとして宣言
  let mut result = ""
  for i in 0..<length {
    /// テンプレートリテラルを使う
    result = result + "\{word_1_arr[i]}\{word_2_arr[i]}"
  }
  result
}

///|
/// StringBuilderを使う
///
/// ```mbt check
/// test {
///   inspect(e_00_6(), content="パタトクカシーー")
/// }
/// ```
pub fn e_00_6() -> String {
  let word_1 : String = "パトカー"
  let word_2 : String = "タクシー"
  let length = if word_1.length() < word_2.length() {
    word_1.length()
  } else {
    word_2.length()
  }

  /// String[i]はCharではなくUInt16を返すので、まずArray[Char]に変換する
  let word_1_arr = word_1.to_array()
  let word_2_arr = word_2.to_array()
  /// 文字列生成にはStringBuilderを使うと効率的らしい
  let builder = StringBuilder::new(size_hint=length * 2)
  for i in 0..<length {
    builder.write_char(word_1_arr[i])
    builder.write_char(word_2_arr[i])
  }
  builder.to_string()
}

///|
/// Iter, Iter2で処理する
///
/// ```mbt check
/// test {
///   inspect(e_01(), content="パトカー")
/// }
/// ```
pub fn e_01() -> String {
  let word = "パタトクカシーー"
  word
  /// Iter2は (index, element)
  |> String::iter2()
  /// Iter2にはmap/filterがないので、Iterに変換する
  |> Iter2::iter()
  |> Iter::filter(pair => pair.0 % 2 == 0)
  |> Iter::map(pair => pair.1)
  |> String::from_iter()
}

///|
/// forループで処理する
///
/// ```mbt check
/// test {
///   inspect(e_01_2(), content="パトカー")
/// }
/// ```
pub fn e_01_2() -> String {
  let word = "パタトクカシーー"
  let arr = word.to_array()
  let builder = StringBuilder::new(size_hint=arr.length() / 2)
  for i in 0..<arr.length() {
    if i % 2 == 0 {
      builder.write_char(arr[i])
    }
  }
  builder.to_string()
}

///|
/// ```mbt check
/// test {
///   inspect(e_02(), content="desserts")
/// }
/// ```
pub fn e_02() -> String {
  let word = "stressed"
  word |> String::rev()
}

///|
/// ```mbt check
/// test {
///   inspect(e_03(), content="[3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9]")
/// }
/// ```
pub fn e_03() -> Array[Int] {
  let sentence = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."
  sentence
  |> String::replace_all(old=",", new="")
  |> String::replace_all(old=".", new="")
  |> String::split(" ")
  |> Iter::map(StringView::length)
  |> Iter::to_array()
}

///|
pub fn e_04() -> Map[String, Int] {
  let sentence = "Hi He Lied Because Boron Could Not Oxidize Fluorine. New Nations Might Also Sign Peace Security Clause. Arthur King Can."
  let one_char_indices_1_based = [1, 5, 6, 7, 8, 9, 15, 16, 19]
  let one_char_indices = one_char_indices_1_based |> Array::map(i => i - 1)
  sentence
  |> String::replace_all(old=",", new="")
  |> String::replace_all(old=".", new="")
  |> String::split(" ")
  |> Iter::iter2()
  |> Iter2::iter()
  |> Iter::map(tuple => {
    let (i, string) = tuple
    if one_char_indices.contains(i) {
      let key = string
        |> StringView::to_string()
        |> String::unsafe_substring(start=0, end=1)
      (key, i + 1)
    } else {
      let key = string
        |> StringView::to_string()
        |> String::unsafe_substring(start=0, end=2)
      (key, i + 1)
    }
  })
  |> Map::from_iter()
}

