import 'package:nike_ecommerce_app/common/http_client.dart';
import 'package:nike_ecommerce_app/data/order.dart';
import 'package:nike_ecommerce_app/data/source/order_data_source.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository {
  Future<CreateOrderResult> create(CreateOrderParams params);
}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource dataSource;

  OrderRepository(this.dataSource);

  @override
  Future<CreateOrderResult> create(CreateOrderParams params) =>
      dataSource.create(params);
}
