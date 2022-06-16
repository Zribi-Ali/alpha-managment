import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../Screans/this/morphisme.dart';
import 'models.dart';
import 'place_item.dart';

class PlaceStoggerdGridView extends StatelessWidget {
  final placelist = Place.generatePlaces();
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      physics: const ScrollPhysics(),
      itemCount: placelist.length,
      itemBuilder: (BuildContext context, int index) => GlassMorphisme(
          blur: 20, opacity: 0.2, child: PlaceItem(placelist[index])),
      staggeredTileBuilder: (_) => const StaggeredTile.fit(2),
    );
  }
}
