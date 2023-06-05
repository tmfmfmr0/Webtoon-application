import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector() : 대부분의 동작을 감지하는 위젯.
      onTap: () {
        Navigator.push(
          // Navigator.push() : 위젯을 route로 빌드해서 반환. 애니메이션 효과를 이용해서 다른 페이지로 이동.
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(title: title, thumb: thumb, id: id),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            // Hero() : 같은 객체를 사용하는 창 전환 시, 같은 태그를 적용하여 애니메이션 제공.
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(1),
                      offset: const Offset(0, 0),
                      blurRadius: 18,
                      spreadRadius: 1),
                ],
              ),
              child: Image.network(
                thumb,
                headers: const {'Referer': 'https://comic.naver.com'},
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
