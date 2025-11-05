// lib/screens/booking_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:veegify/model/order.dart';
import 'package:veegify/provider/BookingProvider/booking_provider.dart';

class BookingScreen extends StatefulWidget {
  final String? userId; // pass the user id here

  const BookingScreen({super.key, required this.userId});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late OrderProvider _orderProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // fetch after first frame so provider is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _orderProvider = Provider.of<OrderProvider>(context, listen: false);
      _orderProvider.loadAllOrders(widget.userId.toString());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildList(List<Order> items) {
    if (items.isEmpty) {
      return Center(child: Text('No orders found'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = items[index];
        return _buildBookingCard(order);
      },
    );
  }

  Widget _buildBookingCard(Order order) {
    final firstProduct = order.products.isNotEmpty ? order.products.first : null;
    final created = DateFormat('dd MMM yyyy, hh:mm a').format(order.createdAt.toLocal());
    final status = order.orderStatus;
    final statusColor = status.toLowerCase() == 'cancelled'
        ? Colors.red
        : (status.toLowerCase() == 'pending' ? Colors.orange : Colors.green);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: firstProduct?.image != null
                  ? Image.network(firstProduct!.image!, width: 100, height: 80, fit: BoxFit.cover)
                  : Container(width: 100, height: 80, color: Colors.grey[200], child: Icon(Icons.fastfood)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  firstProduct?.name ?? order.restaurant.restaurantName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text('₹${order.subTotal.toStringAsFixed(2)} • ${order.totalItems} items',
                    style: const TextStyle(fontSize: 13, color: Colors.black54)),
                const SizedBox(height: 6),
                Text(order.restaurant.locationName, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 6),
                Text(created, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ]),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // TODO: open order detail / tracking
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => _buildOrderDetailSheet(order),
                    );
                  },
                  child: const Text('Details'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetailSheet(Order order) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Order ID: ${order.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Restaurant: ${order.restaurant.restaurantName}'),
        const SizedBox(height: 8),
        Text('Address: ${order.deliveryAddress.street}, ${order.deliveryAddress.city}'),
        const SizedBox(height: 8),
        Text('Payment: ${order.paymentMethod} • ${order.paymentStatus}'),
        const SizedBox(height: 8),
        Text('Total: ₹${order.totalPayable.toStringAsFixed(2)}'),
        const SizedBox(height: 12),
        const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...order.products.map((p) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(p.name),
              subtitle: Text('${p.quantity} x ₹${p.basePrice.toStringAsFixed(2)}'),
              trailing: Text('₹${(p.quantity * p.basePrice).toStringAsFixed(2)}'),
            )),
        const SizedBox(height: 12),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    final isLoading = provider.state == OrdersState.loading;
    final error = provider.error;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
            centerTitle: true,
        title: const Text("Bookings",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TabBar(
  controller: _tabController,
  isScrollable: true,

  // use the indicator as the green rounded pill
  indicator: BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.22), blurRadius: 6, offset: const Offset(0,3))],
  ),
  indicatorSize: TabBarIndicatorSize.tab,

  // remove underline/divider/ripple visuals
  indicatorColor: Colors.transparent,
  overlayColor: MaterialStateProperty.all(Colors.transparent),
  dividerColor: Colors.transparent,

  // label colors applied to Tab children text/icons when not explicitly colored
  labelColor: Colors.white,
  unselectedLabelColor: Colors.black87,
  labelPadding: const EdgeInsets.symmetric(horizontal: 12),

  tabs: [
    // Today Bookings
    Tab(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              // do not force background color here unless you want it permanent;
              // keep transparent so indicator paints the selected pill.
              color: _tabController.index == 0 ? Colors.green : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: _tabController.index == 0 ? null : Border.all(color: Colors.grey.shade300, width: 1),
              boxShadow: _tabController.index == 0
                  ? [BoxShadow(color: Colors.green.withOpacity(0.22), blurRadius: 6, offset: const Offset(0,3))]
                  : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 3, offset: const Offset(0,1))],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 8),
                Text(
                  "Today Bookings",
                  style: TextStyle(
                    color: _tabController.index == 0 ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 6), // reserve space for badge
              ],
            ),
          ),
          Positioned(
            right: -10,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _tabController.index == 0 ? Colors.white : Colors.green,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3, offset: const Offset(0,2))],
                  border: _tabController.index == 0 ? null : Border.all(color: Colors.green, width: 0),
                ),
                child: Icon(Icons.calendar_today, size: 16, color: _tabController.index == 0 ? Colors.green : Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),

    // Total Bookings
    Tab(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: _tabController.index == 1 ? Colors.green : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: _tabController.index == 1 ? null : Border.all(color: Colors.grey.shade300, width: 1),
              boxShadow: _tabController.index == 1
                  ? [BoxShadow(color: Colors.green.withOpacity(0.22), blurRadius: 6, offset: const Offset(0,3))]
                  : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 3, offset: const Offset(0,1))],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 8),
                Text(
                  "Total Bookings",
                  style: TextStyle(
                    color: _tabController.index == 1 ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
          Positioned(
            right: -10,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _tabController.index == 1 ? Colors.white : Colors.green,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3, offset: const Offset(0,2))],
                ),
                child: Icon(Icons.block, size: 16, color: _tabController.index == 1 ? Colors.green : Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),

    // Cancelled Bookings
    Tab(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: _tabController.index == 2 ? Colors.green : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: _tabController.index == 2 ? null : Border.all(color: Colors.grey.shade300, width: 1),
              boxShadow: _tabController.index == 2
                  ? [BoxShadow(color: Colors.green.withOpacity(0.22), blurRadius: 6, offset: const Offset(0,3))]
                  : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 3, offset: const Offset(0,1))],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 8),
                Text(
                  "Cancelled Bookings",
                  style: TextStyle(
                    color: _tabController.index == 2 ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
          Positioned(
            right: -10,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _tabController.index == 2 ? Colors.white : Colors.green,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3, offset: const Offset(0,2))],
                ),
                child: Icon(Icons.close, size: 16, color: _tabController.index == 2 ? Colors.green : Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  ],
  onTap: (i) {
    // ensure immediate rebuild on tap
    setState(() {});
  },
),


          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text('Error: $error'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () => provider.loadAllOrders(widget.userId.toString()),
                        child: const Text('Retry')),
                  ]),
                )
              : TabBarView(controller: _tabController, children: [
                  RefreshIndicator(
                    onRefresh: () => provider.loadAllOrders(widget.userId.toString()),
                    child: _buildList(provider.todayOrders),
                  ),
                  RefreshIndicator(
                    onRefresh: () => provider.loadAllOrders(widget.userId.toString()),
                    child: _buildList(provider.orders),
                  ),
                  RefreshIndicator(
                    onRefresh: () => provider.loadAllOrders(widget.userId.toString()),
                    child: _buildList(provider.cancelledOrders),
                  ),
                ]),
    );
  }
}
