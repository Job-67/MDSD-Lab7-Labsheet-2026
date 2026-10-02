import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../models/favorites_model.dart';
import '../models/cart_model.dart';

class ItemCard extends StatelessWidget {
  final Item item; // เหลือแค่พารามิเตอร์เดียว ไม่ต้องรับ savedItems/onSave อีกต่อไป

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // .watch ที่นี่เพื่อให้ปุ่มอัปเดตสถานะ "บันทึกแล้ว" ทันทีที่ FavoritesModel เปลี่ยนจากจุดใดก็ตาม
    final favorites = context.watch<FavoritesModel>();
    final alreadySaved = favorites.items.any((i) => i.id == item.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text('฿${item.price.toStringAsFixed(0)}'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: alreadySaved
                        ? null
                        : () {
                            // .read ที่นี่เพราะเป็นคำสั่งครั้งเดียวตอนกด ไม่ต้องการสมัครรับการอัปเดตซ้ำ
                            context.read<FavoritesModel>().add(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('บันทึก ${item.title} ไว้ในรายการโปรดแล้ว')),
                            );
                          },
                    child: Text(alreadySaved ? '❤️ บันทึกแล้ว' : '🤍 บันทึกรายการโปรด'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<CartModel>().add(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('เพิ่ม ${item.title} ลงตะกร้าแล้ว')),
                      );
                    },
                    child: const Text('🛒 เพิ่มลงตะกร้า'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
