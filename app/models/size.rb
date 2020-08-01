class Size < ActiveHash::Base
  self.data = [
      {id: 1, name: 'XXS以下'}, {id: 2, name: 'XS(SS)'}, {id: 3, name: 'S'},
      {id: 4, name: 'M'}, {id: 5, name: 'L'}, {id: 6, name: 'XL（LL）'},
      {id: 7, name: '２XL（３L）'}, {id: 8, name: '３XL（４L）'}, {id: 9, name: '４XL（５L）'},
      {id: 10, name: 'FREESIZE'}, 
  ]
end