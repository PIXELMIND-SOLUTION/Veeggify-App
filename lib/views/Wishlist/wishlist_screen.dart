import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veegify/helper/storage_helper.dart';
import 'package:veegify/model/wishlist_model.dart';
import 'package:veegify/provider/WishListProvider/wishlist_provider.dart';
import 'package:veegify/widgets/bottom_navbar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  String? userId;
  bool _initialLoadTried = false; // avoid repeated fetch attempts

  BottomNavbarProvider? _bottomNavbarProvider; // 👈 added
  VoidCallback? _bottomNavListener; // 👈 added
  static const int _wishlistTabIndex = 1; // 👈 your favourites tab index

  @override
  void initState() {
    super.initState();
    debugPrint('WishlistScreen.initState called');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserIdAndFetch();

      // 👇 Attach listener to BottomNavbarProvider
      try {
        _bottomNavbarProvider =
            Provider.of<BottomNavbarProvider>(context, listen: false);
        _bottomNavListener = () {
          final idx = _bottomNavbarProvider?.currentIndex;
          debugPrint('Bottom nav index changed: $idx');
          if (idx == _wishlistTabIndex) {
            debugPrint('Wishlist tab became active, refreshing...');
            if (userId == null || userId!.isEmpty) {
              _loadUserIdAndFetch();
            } else {
              print("ksfjsfffjkfjfjkfj;kfj;fjfsfj;jfsfjksf;sfsklfjdslkfjfjdsfjdsfjsdfjsdfjsdlk");
              context.read<WishlistProvider>().fetchWishlist(userId!);
            }
          }
        };
        _bottomNavbarProvider?.addListener(_bottomNavListener!);
        debugPrint('Attached bottomNav listener in WishlistScreen ✅');
      } catch (e, st) {
        debugPrint('Could not attach BottomNavbarProvider listener: $e\n$st');
      }
    });
  }

  @override
  void dispose() {
    try {
      if (_bottomNavbarProvider != null && _bottomNavListener != null) {
        _bottomNavbarProvider!.removeListener(_bottomNavListener!);
      }
    } catch (_) {}
    super.dispose();
  }

  /// Make sure this returns after userId is set (async)
  Future<String?> _loadUserId() async {
    try {
      debugPrint('-> _loadUserId start');
      final user = await Future.value(UserPreferences.getUser());
      debugPrint('UserPreferences.getUser() => $user');
      if (user != null && mounted) {
        setState(() {
          userId = user.userId;
        });
        debugPrint('Loaded userId: $userId');
        return userId;
      } else {
        debugPrint('No user found in preferences');
        return null;
      }
    } catch (e, st) {
      debugPrint('_loadUserId error: $e\n$st');
      return null;
    }
  }

  /// Single place to initialize wishlist safely
  Future<void> _loadUserIdAndFetch() async {
    if (!mounted) return;
    debugPrint('>>> _loadUserIdAndFetch START');

    try {
      final loadedUserId = await _loadUserId();

      if (loadedUserId == null || loadedUserId.isEmpty) {
        debugPrint('No userId available - aborting fetchWishlist');
        return;
      }

      final providerAvailable =
          Provider.of<WishlistProvider>(context, listen: false);
      if (providerAvailable == null) {
        debugPrint('WishlistProvider NOT found in widget tree!');
        return;
      } else {
        debugPrint('WishlistProvider found.');
      }

      if (_initialLoadTried) {
        debugPrint('Initial load already tried, skipping fetchWishlist');
        return;
      }
      _initialLoadTried = true;

      debugPrint('Calling fetchWishlist for userId: $loadedUserId');
      await context.read<WishlistProvider>().fetchWishlist(loadedUserId);
      debugPrint(
          'fetchWishlist completed, list length: ${context.read<WishlistProvider>().wishlist.length}');
    } catch (e, st) {
      debugPrint('Exception in _loadUserIdAndFetch: $e\n$st');
    } finally {
      debugPrint('<<< _loadUserIdAndFetch END');
    }
  }

  Future<void> _refreshWishlist() async {
    if (userId != null) {
      try {
        await context.read<WishlistProvider>().fetchWishlist(userId!);
      } catch (e, st) {
        debugPrint('Error refreshing wishlist: $e\n$st');
      }
    } else {
      await _loadUserIdAndFetch();
    }
  }

  void _showRemoveDialog(
      BuildContext context, WishlistProduct product, WishlistProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Remove from Wishlist'),
        content: Text(
            'Are you sure you want to remove "${product.name}" from your wishlist?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () {
              if (userId != null) {
                provider.toggleWishlist(userId!, product.id);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Unable to remove: user not found'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} removed from wishlist'),
                  backgroundColor: Colors.red[400],
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Row(
          children: [
            Icon(Icons.favorite, color: Colors.red[400]),
            const SizedBox(width: 8),
            const Text(
              'My Wishlist',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          Consumer<WishlistProvider>(
            builder: (context, wishlistProvider, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${wishlistProvider.wishlist.length} items',
                      style: TextStyle(
                        color: Colors.red[600],
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: userId == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.red[400]!),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading user data...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          : Consumer<WishlistProvider>(
              builder: (context, wishlistProvider, child) {
                if (wishlistProvider.error.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            size: 64, color: Colors.red[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Oops! Something went wrong',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          wishlistProvider.error,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            wishlistProvider.clearError();
                            _refreshWishlist();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (wishlistProvider.isLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.red[400]!),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Loading your wishlist...',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (wishlistProvider.wishlist.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.favorite_border,
                              size: 64, color: Colors.grey[400]),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Your wishlist is empty',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Save your favorite items to see them here',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Normal List
                return RefreshIndicator(
                  onRefresh: _refreshWishlist,
                  color: Colors.red[400],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: wishlistProvider.wishlist.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, color: Colors.transparent),
                      itemBuilder: (context, index) {
                        final product = wishlistProvider.wishlist[index];
                        return WishlistListItem(
                          product: product,
                          onRemove: () =>
                              _showRemoveDialog(context, product, wishlistProvider),
                          onAdd: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Added ${product.name} to cart')),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class WishlistListItem extends StatefulWidget {
  final WishlistProduct product;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

  const WishlistListItem({
    Key? key,
    required this.product,
    required this.onRemove,
    required this.onAdd,
  }) : super(key: key);

  @override
  State<WishlistListItem> createState() => _WishlistListItemState();
}

class _WishlistListItemState extends State<WishlistListItem> {
  bool _expanded = false;

  String safeString(String? s, [String fallback = '']) {
    if (s == null) return fallback;
    return s;
  }

  @override
  Widget build(BuildContext context) {
    const imageSize = 100.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.only(right: 8, top: 2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        safeString(widget.product.name, 'Unnamed product'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '₹${widget.product.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: RichText(
                    maxLines: _expanded ? 10 : 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey[700]),
                      children: <TextSpan>[
                        TextSpan(
                            text: safeString(
                                widget.product.description,
                                'Deliciously decadent flavored food')),
                        if (!_expanded)
                          TextSpan(
                            text: ' more',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w700),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                  image: widget.product.image.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(widget.product.image),
                          fit: BoxFit.cover)
                      : null,
                ),
                child: widget.product.image.isEmpty
                    ? Icon(Icons.image_outlined,
                        size: 40, color: Colors.grey[400])
                    : null,
              ),
              Positioned(
                top: -8,
                right: -8,
                child: Material(
                  color: Colors.white,
                  elevation: 2,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: widget.onRemove,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.favorite,
                          color: Colors.red[400], size: 18),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -12,
                left: (imageSize / 2) - 28,
                child: GestureDetector(
                  onTap: widget.onAdd,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: const Text(
                      'ADD',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
