class NumberModel {
  final int value;
  final bool isHighlighted;

  NumberModel({
    required this.value,
    this.isHighlighted = false,
  });

  // Converte para NumberModel
  static List<NumberModel> fromList(List<int> numbers) {
    return numbers.map((number) => NumberModel(value: number)).toList();
  }

  //Converte novamente para integer
  static List<int> toList(List<NumberModel> models) {
    return models.map((model) => model.value).toList();
  }
}
