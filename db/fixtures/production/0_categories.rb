Category.seed(:id,
  { id: 1, name: "猫" },
  { id: 2, name: "犬" },
  { id: 3, name: "子猫", ancestry: 1 },
  { id: 4, name: "子犬", ancestry: 2 },
)