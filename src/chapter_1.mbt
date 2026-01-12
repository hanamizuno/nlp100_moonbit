/// https://nlp100.github.io/2025/ja/ch01.html

///|
/// メソッドチェーンを使う
pub fn e_00() -> Unit {
  let word_1 : String = "パトカー"
  let word_2 : String = "タクシー"
  let result = word_1
    .to_array()
    .zip(word_2.to_array())
    /// `(a, b) => a + b` みたいな書き方はできない
    .map(pair => String::from_array([pair.0, pair.1]))
    .join("")
  println(result)
}

///|
/// パイプライン演算子を使う
pub fn e_00_2() -> Unit {
  let word_1 : String = "パトカー"
  let word_2 : String = "タクシー"
  let result = word_1
    |> String::to_array()
    |> Array::zip(word_2.to_array())
    |> Array::map(pair => String::from_array([pair.0, pair.1]))
    |> Array::join("")
  println(result)
}

///|
/// zipをmatchと再帰で実装してみる
pub fn e_00_3() -> Unit {
  let word_1 : String = "パトカー"
  let word_2 : String = "タクシー"

  /// ローカル関数の定義には型引数を使えないので、Charに固定
  fn zip(a : Array[Char], b : Array[Char]) -> Array[(Char, Char)] {
    match (a, b) {
      ([], _) => []
      (_, []) => []
      ([hd_a, .. tl_a], [hd_b, .. tl_b]) =>
        [(hd_a, hd_b)] + zip(tl_a.to_array(), tl_b.to_array())
    }
  }

  let result = zip(word_1.to_array(), word_2.to_array())
    |> Array::map(pair => String::from_array([pair.0, pair.1]))
    |> Array::join("")
  println(result)
}

///|
/// 型引数の使用例
pub fn[A, B] zip_(a : Array[A], b : Array[B]) -> Array[(A, B)] {
  match (a, b) {
    ([], _) => []
    (_, []) => []
    ([hd_a, .. tl_a], [hd_b, .. tl_b]) =>
      [(hd_a, hd_b)] + zip_(tl_a.to_array(), tl_b.to_array())
  }
}

///|
/// forループを使う
pub fn e_00_4() -> Unit {
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
  println(result_array.join(""))
}

///|
pub fn e_00_5() -> Unit {
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
  println(result)
}

///|
/// StringBuilderを使う
pub fn e_00_6() -> Unit {
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
  let result = builder.to_string()
  println(result)
}

///|
/// Iter, Iter2で処理する
pub fn e_01() -> Unit {
  let word = "パタトクカシーー"
  let result = word
    /// Iter2は (index, element)
    |> String::iter2()
    /// Iter2にはmap/filterがないので、Iterに変換する
    |> Iter2::iter()
    |> Iter::filter(pair => pair.0 % 2 == 0)
    |> Iter::map(pair => pair.1)
    |> Iter::to_array()
    |> String::from_array()
  println(result)
}

///|
/// forループで処理する
pub fn e_01_2() -> Unit {
  let word = "パタトクカシーー"
  let arr = word.to_array()
  let result : Array[Char] = []
  for i in 0..<arr.length() {
    if i % 2 == 0 {
      result.push(arr[i])
    }
  }
  println(String::from_array(result))
}

///|
pub fn e_02() -> Unit {
  let word = "stressed"
  let result = word |> String::rev()
  println(result)
}
