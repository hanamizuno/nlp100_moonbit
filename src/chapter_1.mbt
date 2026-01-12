///|
pub fn e_00() -> Unit {
  let word_1 : String = "パトカー"
  let word_2 : String = "タクシー"
  let result = word_1
    .to_array()
    .zip(word_2.to_array())
    .map(pair => String::from_array([pair.0, pair.1]))
    .join("")
  println(result)
}
