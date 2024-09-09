import 'package:apple_shop/data/dataSource/banner_data_source.dart';
import 'package:apple_shop/models/banner.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerModel>>> getBanners();
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;

  BannerRepository({required this.dataSource});
  @override
  Future<Either<String, List<BannerModel>>> getBanners() async {
    try {
      List<BannerModel> bannerList = await dataSource.getBanners();
      return right(bannerList);
    } on ApiException catch (e) {
      return left(e.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
