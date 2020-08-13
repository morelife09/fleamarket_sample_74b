class Brand < ActiveHash::Base
  self.data = [
      {id: 1, name: 'シャネル'}, {id: 2, name: 'ルイヴィトン'}, {id: 3, name: 'ユニクロ'},
      {id: 4, name: 'しまむら'}, {id: 5, name: 'ナイキ'}, {id: 6, name: 'ディオール'},
      {id: 7, name: 'ティファニー'}, {id: 8, name: 'ポーター'}, {id: 9, name: 'プラダ'},
      {id: 10, name: 'その他'}, 
  ]
end