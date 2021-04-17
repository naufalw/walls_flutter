import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:walls_flutter/screens/preview_screen.dart';

class AllWallPapersScreen extends StatefulWidget {
  final List allWallLink;
  const AllWallPapersScreen({this.allWallLink});
  @override
  _AllWallPapersScreenState createState() => _AllWallPapersScreenState();
}

class _AllWallPapersScreenState extends State<AllWallPapersScreen> {
  List allWallLink;
  @override
  void initState() {
    super.initState();
    allWallLink = widget.allWallLink;
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      indicatorColor: Colors.black45,
      borderColor: Colors.black87,
      backgroundColor: Colors.black87,
      borderWidth: 0.0,
      barrierColor: Colors.black45,
      indicatorWidget: Center(
        child: SpinKitDoubleBounce(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("All WallPapers"),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0.0,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverGrid(
                  delegate:
                      SliverChildBuilderDelegate((BuildContext ctx, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 3),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl: allWallLink[index]["thumb"],
                                fit: BoxFit.cover,
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    String url = allWallLink[index]["url"];
                                    ProgressHUD.of(ctx).show();
                                    var file = await DefaultCacheManager()
                                        .getSingleFile(url);
                                    if (file != null) {
                                      ProgressHUD.of(ctx).dismiss();
                                      Get.to(() => PreviewScreen(
                                            url: url,
                                            imgPath: file,
                                          ));
                                    }
                                  },
                                ),
                              )
                            ],
                          )),
                    );
                  }, childCount: allWallLink.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
