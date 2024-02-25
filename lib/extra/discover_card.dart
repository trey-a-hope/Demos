import 'package:flutter/material.dart';

class DiscoverCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final Function? onTap;
  final String? tag;
  final String imgPath;
  const DiscoverCard({
    Key? key,
    this.title,
    this.subtitle,
    this.gradientStartColor,
    this.gradientEndColor,
    this.height,
    this.width,
    this.vectorBottom,
    this.vectorTop,
    this.onTap,
    this.tag,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap!(),
        borderRadius: BorderRadius.circular(26),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(
                  imgPath,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.colorBurn,
                )),
            gradient: LinearGradient(
              colors: [
                gradientStartColor ?? const Color(0xff441DFC),
                gradientEndColor ?? const Color(0xff4E81EB),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          height: 176,
          width: 305,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 24, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: tag ?? '',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              title!,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        subtitle != null
                            ? Text(
                                subtitle!,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              )
                            : Container(),
                      ],
                    ),
                    const Row(
                      children: [
                        // SvgAsset(
                        //   assetName: AssetName.headphone,
                        //   height: 24,
                        //   width: 24,
                        // ),
                        SizedBox(width: 24),
                        // SvgAsset(
                        //   assetName: AssetName.tape,
                        //   height: 24,
                        //   width: 24,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
