import 'package:flutter_riverpod/flutter_riverpod.dart';

// 定義一個類來存儲和管理 levels 資料
class LevelInfoProvider {
  final List<Map<String, dynamic>> levels = [
    {
      "level": "1",
      "dish": "三杯雞",
      "dish_img_url": "assets/images/ingredients/三杯雞/dish.png",
      "recipe": {
        "ingredients": ["雞腿肉", "九層塔", "薑", "蒜", "醬油", "米酒", "麻油"],
        "steps": [
          "熱鍋加入麻油，炒香薑片和蒜頭。",
          "加入雞腿肉炒至變色。",
          "加入醬油和米酒煮至入味。",
          "最後加入九層塔，拌炒均勻。"
        ]
      }
    },
    {
      "level": "2",
      "dish": "蚵仔煎",
      "dish_img_url": "assets/images/ingredients/蚵仔煎/dish.png",
      "recipe": {
        "ingredients": ["蚵仔", "雞蛋", "太白粉水", "高麗菜絲", "甜辣醬"],
        "steps": [
          "熱鍋，加入油煎蚵仔。",
          "倒入太白粉水，煎至透明。",
          "加入打散的雞蛋和高麗菜絲。",
          "煎至兩面金黃，淋上甜辣醬。"
        ]
      }
    },
    {
      "level": "3",
      "dish": "蛋花湯",
      "dish_img_url": "assets/images/ingredients/蛋花湯/dish.png",
      "recipe": {
        "ingredients": ["雞蛋", "高湯", "蔥", "鹽"],
        "steps": ["高湯煮滾。", "雞蛋打散，慢慢倒入滾湯中，輕輕攪拌。", "加鹽調味。", "撒上蔥花。"]
      }
    },
    {
      "level": "4",
      "dish": "番茄炒蛋",
      "dish_img_url": "assets/images/ingredients/番茄炒蛋/dish.png",
      "recipe": {
        "ingredients": ["番茄", "雞蛋", "蔥", "鹽", "糖"],
        "steps": [
          "番茄切塊，雞蛋打散。",
          "熱鍋加油，倒入蛋液炒至半熟，盛出。",
          "同鍋加油，炒香番茄，加入少許鹽和糖調味。",
          "將半熟的蛋倒回鍋中，拌炒均勻，撒上蔥花。"
        ]
      }
    },
    {
      "level": "5",
      "dish": "虱目魚肚粥",
      "dish_img_url": "assets/images/ingredients/虱目魚肚粥/dish.png",
      "recipe": {
        "ingredients": ["虱目魚肚", "米", "薑", "鹽"],
        "steps": ["虱目魚肚切片，米洗淨。", "鍋中加水，加入米和薑片煮開。", "加入魚肚片，煮至魚熟。", "加鹽調味。"]
      }
    },
    {
      "level": "6",
      "dish": "空心菜炒牛肉",
      "dish_img_url": "assets/images/ingredients/空心菜炒牛肉/dish.png",
      "recipe": {
        "ingredients": ["空心菜", "牛肉片", "蒜", "醬油"],
        "steps": ["熱鍋加油，炒香蒜末。", "加入牛肉片，快速炒至變色。", "加入空心菜，拌炒均勻。", "加醬油調味。"]
      }
    },
    {
      "level": "7",
      "dish": "麻油雞",
      "dish_img_url": "assets/images/ingredients/麻油雞/dish.png",
      "recipe": {
        "ingredients": ["雞腿肉", "麻油", "米酒", "薑"],
        "steps": ["熱鍋加麻油，炒香薑片。", "加入雞腿肉炒至變色。", "加入米酒煮至雞肉熟透。"]
      }
    },
    {
      "level": "8",
      "dish": "紅燒豆腐",
      "dish_img_url": "assets/images/ingredients/紅燒豆腐/dish.png",
      "recipe": {
        "ingredients": ["豆腐", "豬絞肉", "醬油", "薑", "蒜"],
        "steps": ["豆腐切塊，豬絞肉炒香。", "熱鍋加油，炒香薑末和蒜末。", "加入豬絞肉和豆腐，加入醬油燉煮。"]
      }
    },
    {
      "level": "9",
      "dish": "炒米粉",
      "dish_img_url": "assets/images/ingredients/炒米粉/dish.png",
      "recipe": {
        "ingredients": ["米粉", "蝦仁", "豬肉絲", "紅蘿蔔", "高麗菜絲", "醬油"],
        "steps": ["米粉泡軟，瀝乾。", "熱鍋加油，炒香蝦仁、豬肉絲、紅蘿蔔絲和高麗菜絲。", "加入米粉拌炒，淋上醬油調味。"]
      }
    },
    {
      "level": "10",
      "dish": "白菜滷",
      "dish_img_url": "assets/images/ingredients/白菜滷/dish.png",
      "recipe": {
        "ingredients": ["大白菜", "香菇", "紅蘿蔔", "豆皮", "粉絲"],
        "steps": [
          "大白菜切段，香菇泡軟。",
          "熱鍋加油，炒香香菇和紅蘿蔔。",
          "加入大白菜和豆皮，倒入水煮滾。",
          "加入粉絲，煮至入味。"
        ]
      }
    },
    {
      "level": "11",
      "dish": "魚香茄子",
      "dish_img_url": "assets/images/ingredients/魚香茄子/dish.png",
      "recipe": {
        "ingredients": ["茄子", "豬絞肉", "豆瓣醬", "蒜", "薑"],
        "steps": ["茄子切段，熱油鍋炸至金黃。", "熱鍋加油，炒香蒜末、薑末和豆瓣醬。", "加入豬絞肉炒熟，再加入茄子拌炒均勻。"]
      }
    },
    {
      "level": "12",
      "dish": "苦瓜炒蛋",
      "dish_img_url": "assets/images/ingredients/苦瓜炒蛋/dish.png",
      "recipe": {
        "ingredients": ["苦瓜", "雞蛋", "蒜", "鹽"],
        "steps": ["苦瓜切片，雞蛋打散。", "熱鍋加油，炒香蒜末。", "加入苦瓜炒至變軟。", "倒入雞蛋液，炒至凝固，加鹽調味。"]
      }
    },
    {
      "level": "13",
      "dish": "薑絲大腸",
      "dish_img_url": "assets/images/ingredients/薑絲大腸/dish.png",
      "recipe": {
        "ingredients": ["豬大腸", "薑", "蔥", "米酒", "醬油"],
        "steps": ["豬大腸洗淨切段，汆燙去腥。", "熱鍋加油，炒香薑絲和青蔥段。", "加入豬大腸拌炒，淋上米酒和醬油燉煮。"]
      }
    },
    {
      "level": "14",
      "dish": "蒜泥白肉",
      "dish_img_url": "assets/images/ingredients/蒜泥白肉/dish.png",
      "recipe": {
        "ingredients": ["五花肉", "蒜", "醬油", "醋", "糖", "辣油"],
        "steps": ["五花肉煮熟，切薄片。", "蒜泥、醬油、醋、糖和辣油混合成醬汁。", "將醬汁淋在五花肉片上。"]
      }
    },
    {
      "level": "15",
      "dish": "皮蛋豆腐",
      "dish_img_url": "assets/images/ingredients/皮蛋豆腐/dish.png",
      "recipe": {
        "ingredients": ["皮蛋", "豆腐", "蔥", "醬油", "香油"],
        "steps": ["皮蛋去殼切小塊，嫩豆腐切塊。", "將皮蛋放在豆腐上。", "淋上醬油和香油，撒上蔥花。"]
      }
    },
    {
      "level": "16",
      "dish": "蛋炒飯",
      "dish_img_url": "assets/images/ingredients/蛋炒飯/dish.png",
      "recipe": {
        "ingredients": ["白飯", "雞蛋", "蔥", "鹽", "醬油"],
        "steps": ["雞蛋打散炒熟，盛出。", "熱鍋加油，加入白飯炒散。", "加入炒熟的雞蛋和蔥花拌炒，調味。"]
      }
    },
  ];
}

// 創建一個 Provider 來提供 LevelProvider 類的實例
final levelInfoProvider = Provider((ref) => LevelInfoProvider());

// 創建一個 StateProvider 來管理當前選擇的 level 狀態
final nowLevelProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
final imageProvider = StateProvider<String?>((ref) => null);
