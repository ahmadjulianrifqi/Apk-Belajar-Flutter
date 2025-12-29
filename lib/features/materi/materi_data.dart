class MateriData {
  final String title;
  final String description;

  MateriData({
    required this.title,
    required this.description,
  });
}

final List<MateriData> materiList = [
  MateriData(
    title: 'Sistem Tata Surya',
    description: 'Mempelajari planet, matahari, dan benda langit.',
  ),
  MateriData(
    title: 'Perubahan Wujud Benda',
    description: 'Mencair, membeku, menguap, dan menyublim.',
  ),
  MateriData(
    title: 'Gaya dan Gerak',
    description: 'Pengaruh gaya terhadap gerak benda.',
  ),
];
