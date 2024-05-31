import 'package:flutter_riverpod/flutter_riverpod.dart';

// 定義一個類來存儲和管理 levels 資料
class LevelInfoProvider {
  final List<Map<String, dynamic>> levels = [
    {
      'level': '1',
      'dish': '三杯雞',
      'dish_img_url': 'assets/images/ingredients/三杯雞/dish.png',
      'recipe': {
        'ingredients': ["雞腿肉", "九層塔", "薑片", "蒜頭", "醬油", "米酒", "麻油"],
        'steps': [
          "熱鍋加入麻油，炒香薑片和蒜頭。",
          "加入雞腿肉炒至變色。",
          "加入醬油和米酒煮至入味。",
          "最後加入九層塔，拌炒均勻。"
        ]
      }
    },
    {
      'level': '2',
      'dish': '蚵仔煎',
      'dish_img_url': 'assets/images/ingredients/蚵仔煎/dish.png',
      'recipe': {
        'ingredients': ["新鮮蚵仔", "雞蛋", "太白粉水", "高麗菜絲", "甜辣醬"],
        'steps': [
          "熱鍋，加入油煎蚵仔。",
          "倒入太白粉水，煎至透明。",
          "加入打散的雞蛋和高麗菜絲。",
          "煎至兩面金黃，淋上甜辣醬。"
        ]
      }
    },
    {
      'level': '3',
      'dish': '蛋花湯',
      'dish_img_url': 'assets/images/ingredients/蛋花湯/dish.png',
      'recipe': {
        'ingredients': ["雞蛋", "高湯", "蔥花", "鹽"],
        'steps': ["高湯煮滾", "雞蛋打散，慢慢倒入滾湯中，輕輕攪拌", "加鹽調味", "撒上蔥花"]
      }
    }
  ];
}

// 創建一個 Provider 來提供 LevelProvider 類的實例
final levelInfoProvider = Provider((ref) => LevelInfoProvider());

// 創建一個 StateProvider 來管理當前選擇的 level 狀態
final nowLevelProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
final imageProvider = StateProvider<String?>((ref) => null);