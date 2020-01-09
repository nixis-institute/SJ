class FilterModel{

  // List<String> brand;

  Map<String,List<String>> prd;
  // List<String> sizes,colors;
  FilterModel({this.prd});
}

final filter_models = FilterModel(
prd: {
  "Brand":[
    "Addidas",
    "Rebook",
    "Nike",
    "Acis"
  ],

  "Colors":[
    "Red",
    "Black",
    "Blue",
    "Pink"
  ],
  "Size":[
    "S",
    "M","L","XL","XLL"
  ],
  "Price":[
    "1000",
    "2000"
  ]
}
);