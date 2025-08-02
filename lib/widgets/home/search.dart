


import 'dart:async';
import 'package:flutter/material.dart';

class FoodItem {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String category;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
  });
}

class SearchBarWithFilter extends StatefulWidget {
  const SearchBarWithFilter({super.key});

  @override
  State<SearchBarWithFilter> createState() => _SearchBarWithFilterState();
}

class _SearchBarWithFilterState extends State<SearchBarWithFilter> {
  final List<FoodItem> foodItems = [
    FoodItem(
      id: '1',
      name: 'Veg Fried Rice',
      description: 'Delicious fried rice with fresh vegetables and spices',
      imageUrl: 'https://cdn.pixabay.com/photo/2017/12/10/14/47/veg-fried-rice-3010016_1280.jpg',
      category: 'Rice',
    ),
    FoodItem(
      id: '2',
      name: 'Veg Pulao',
      description: 'Aromatic basmati rice cooked with vegetables and mild spices',
      imageUrl: 'https://cdn.pixabay.com/photo/2018/02/25/07/15/veg-pulao-3179602_1280.jpg',
      category: 'Rice',
    ),
    FoodItem(
      id: '3',
      name: 'Veg Burger',
      description: 'Juicy veg patty with fresh lettuce, tomato and special sauce',
      imageUrl: 'https://cdn.pixabay.com/photo/2016/03/05/19/02/hamburger-1238246_1280.jpg',
      category: 'Fast Food',
    ),
    FoodItem(
      id: '4',
      name: 'Veg Pizza',
      description: 'Thin crust pizza topped with bell peppers, onions and olives',
      imageUrl: 'https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_1280.jpg',
      category: 'Italian',
    ),
    FoodItem(
      id: '5',
      name: 'Vegetable Biryani',
      description: 'Fragrant basmati rice layered with spiced vegetables',
      imageUrl: 'https://cdn.pixabay.com/photo/2021/02/28/09/43/vegetable-biryani-6057066_1280.jpg',
      category: 'Rice',
    ),
    FoodItem(
      id: '6',
      name: 'Paneer Tikka',
      description: 'Grilled cottage cheese marinated in spices and yogurt',
      imageUrl: 'https://cdn.pixabay.com/photo/2017/06/30/04/58/paneer-tikka-2457236_1280.jpg',
      category: 'Appetizer',
    ),
    FoodItem(
      id: '7',
      name: 'Dal Tadka',
      description: 'Yellow lentils tempered with garlic and spices',
      imageUrl: 'https://cdn.pixabay.com/photo/2017/02/15/10/39/dal-2069021_1280.jpg',
      category: 'Curry',
    ),
    FoodItem(
      id: '8',
      name: 'Palak Paneer',
      description: 'Soft paneer cubes in creamy spinach gravy',
      imageUrl: 'https://cdn.pixabay.com/photo/2016/03/23/15/00/palak-paneer-1275130_1280.jpg',
      category: 'Curry',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  int _currentIndex = 0;
  Timer? _timer;
  bool _isSearching = false;
  List<FoodItem> _searchResults = [];
  List<String> _recentSearches = ['Veg Burger', 'Paneer Tikka', 'Dal Tadka'];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!_isSearching) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % foodItems.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
        _isSearching = false;
      } else {
        _isSearching = true;
        // Search in both name and description
        _searchResults = foodItems
            .where((item) =>
                item.name.toLowerCase().contains(query.toLowerCase()) ||
                item.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _addToRecentSearches(String query) {
    if (query.isNotEmpty && !_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) {
          _recentSearches.removeLast();
        }
      });
    }
  }

  Future<void> _showSearchModal(BuildContext context) async {
    _searchController.clear();
    _searchResults = [];
    _isSearching = false;
    
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation1,
            curve: Curves.easeOut,
          )),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  // Status bar padding
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  // Search bar section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _searchFocusNode,
                            autofocus: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFEBF4F1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search for restaurants, dishes...",
                              hintStyle: const TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 0),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        _searchController.clear();
                                        _performSearch('');
                                      },
                                    )
                                  : null,
                            ),
                            onChanged: _performSearch,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 46,
                          width: 46,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.tune,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // Search results section
                  Expanded(
                    child: _isSearching
                        ? _searchResults.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.search_off, size: 50, color: Colors.grey),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No results found for "${_searchController.text}"',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: _searchResults.length,
                                itemBuilder: (context, index) {
                                  final item = _searchResults[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(item.imageUrl),
                                      radius: 25,
                                    ),
                                    title: Text(item.name),
                                    subtitle: Text(
                                      item.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                                    onTap: () {
                                      _addToRecentSearches(item.name);
                                      Navigator.pop(context);
                                      // Handle item selection
                                    },
                                  );
                                },
                              )
                        : ListView(
                            children: [
                              if (_recentSearches.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Recent Searches',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              if (_recentSearches.isNotEmpty)
                                ..._recentSearches.map((search) => ListTile(
                                      leading: const Icon(Icons.history, color: Colors.grey),
                                      title: Text(search),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.close, size: 16),
                                        onPressed: () {
                                          setState(() {
                                            _recentSearches.remove(search);
                                          });
                                        },
                                      ),
                                      onTap: () {
                                        _searchController.text = search;
                                        _performSearch(search);
                                      },
                                    )),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Popular Items',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              ...foodItems.take(3).map((item) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(item.imageUrl),
                                      radius: 25,
                                    ),
                                    title: Text(item.name),
                                    subtitle: Text(
                                      item.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () {
                                      _addToRecentSearches(item.name);
                                      Navigator.pop(context);
                                      // Handle item selection
                                    },
                                  )),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    
    // Reset state after modal is closed
    _searchController.clear();
    setState(() {
      _isSearching = false;
      _searchResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final hintText = "Search for '${foodItems[_currentIndex].name}'";

    return GestureDetector(
      onTap: () => _showSearchModal(context),
      child: AbsorbPointer(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFEBF4F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 46,
              width: 46,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.tune,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}