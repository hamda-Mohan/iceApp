import 'package:flutter/material.dart';
import 'package:ice_cream_app/screens/profile_page.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import 'detail_page.dart';
import 'favorite_page.dart';
import 'cart_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  int _selectedIndex = 0;
  final List<Product> _products = [
    Product(
      name: 'Vanilla',
      price: 1.0,
      imageUrl:
          'https://media.istockphoto.com/id/1090251878/photo/ice-cream-balls-in-paper-cup.jpg?s=612x612&w=0&k=20&c=QlII4k-Q2phcY190xGomdSsGwv-ab4jStWIhl_d5ndI=',
    ),
    Product(
      name: 'Strawberry',
      price: 2.0,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgP4B9kfefnfWIuJ-2TY8FF6wFxc92wj1cN6qRwLbRkDjcJQfbveogztNH68TYpLL94Oo&usqp=CAU',
    ),
    Product(
      name: 'Magnum',
      price: 1.5,
      imageUrl:
          'https://www.siftandsimmer.com/wp-content/uploads/2023/03/homemade-magnum-ice-cream-bars-featured.jpg',
    ),
    Product(
      name: 'Mango',
      price: 2.5,
      imageUrl:
          'https://veenaazmanov.com/wp-content/uploads/2017/08/Homemade-Mango-Ice-Cream-No-Churn-Recipe5.jpg',
    ),
    Product(
      name: 'Rolle',
      price: 1.0,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwSH1xwdAsPBTNxEo_onULQJiiZ8mvE1tO7jhw9w5NpeJiytnLH79A4acpTPdZz4AQD7U&usqp=CAU',
    ),
    Product(
      name: 'Cone vanilla',
      price: 1.5,
      imageUrl:
          'https://s7d1.scene7.com/is/image/mcdonaldsstage/DC_202106_0336_LargeVanillaCone_1564x1564:product-header-mobile?wid=1313&hei=1313&dpr=off',
    ),
    Product(
      name: ' Cone oreo',
      price: 3.0,
      imageUrl:
          'https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2FPhoto%2FRecipe%20Ramp%20Up%2F2022-06-Ice-Cream-Cones%2Fwaffle_cone_2_of_2',
    ),
    Product(
      name: 'chocolate',
      price: 3.5,
      imageUrl:
          'https://www.shutterstock.com/image-photo/two-scoops-chocolate-ice-cream-600nw-2485263183.jpg',
    ),
  ];

  final List<CartItem> _cartItems = [];

  void _toggleFavorite(Product product) {
    setState(() {
      product.isFavorite = !product.isFavorite;
    });
  }

  void _addToCart(Product product, int quantity) {
    setState(() {
      _cartItems.add(
        CartItem(
          name: product.name,
          price: product.price,
          imageUrl: product.imageUrl,
          quantity: quantity,
        ),
      );
      _selectedIndex = 2; // Switch to cart page
    });
  }

  void _updateCartItemQuantity(int index, int quantity) {
    setState(() {
      if (quantity > 0) {
        _cartItems[index].quantity = quantity;
      }
    });
  }

  void _removeCartItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MenuPage(
        products: _products,
        onToggleFavorite: _toggleFavorite,
        onAddToCart: _addToCart,
      ),
      FavoritePage(
        favoriteProducts: _products.where((p) => p.isFavorite).toList(),
        onToggleFavorite: _toggleFavorite,
      ),
      CartPage(
        cartItems: _cartItems,
        updateQuantity: _updateCartItemQuantity,
        removeItem: _removeCartItem,
      ),
      ProfilePage(
        
      )
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.lightBlue[200],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class MenuPage extends StatefulWidget {
  final List<Product> products;
  final Function(Product) onToggleFavorite;
  final Function(Product, int) onAddToCart;

  const MenuPage({
    super.key,
    required this.products,
    required this.onToggleFavorite,
    required this.onAddToCart,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<Product> get filteredProducts {
    if (searchQuery.isEmpty) {
      return widget.products;
    }
    return widget.products
        .where((product) =>
            product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 24,
                      color: const Color.fromARGB(255, 30, 155, 223),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_outline),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Subtitle
              Text(
                'Discover and Enjoy the best flavor',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.lightBlue[200],
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),

              // Product Grid
              Expanded(
                child: filteredProducts.isEmpty
                    ? const Center(
                        child: Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    product: product,
                                    onToggleFavorite: () =>
                                        widget.onToggleFavorite(product),
                                    onAddToCart: (quantity) =>
                                        widget.onAddToCart(product, quantity),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue[50],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        product.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 9),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${product.price}\$',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      IconButton(
                                        icon: Icon(
                                          product.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 25,
                                          color: product.isFavorite
                                              ? Colors.pink
                                              : Colors.grey[600],
                                        ),
                                        onPressed: () =>
                                            widget.onToggleFavorite(product),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
