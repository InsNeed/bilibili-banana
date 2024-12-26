abstract class UseCase<Type, Params> {//返回值类型,参数
  Future<Type> call({Params params});
}
