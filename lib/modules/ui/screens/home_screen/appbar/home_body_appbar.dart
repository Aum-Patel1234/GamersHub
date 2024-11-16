part of 'home_screen_appbar.dart';

class HomeBodyAppbar extends StatelessWidget {
  const HomeBodyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: ClipOval(
                  child: Image.network(
                    "https://static.vecteezy.com/system/resources/thumbnails/033/129/417/small/a-business-man-stands-against-white-background-with-his-arms-crossed-ai-generative-photo.jpg",
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome Back 👏',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.read<AuthBloc>().state.userModel?.username ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  // Handle search action
                },
                icon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Handle notifications action
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const TabBar(
            isScrollable: true,
            labelColor: Colors.green,
            indicatorColor: Colors.green,
            tabs: [
              Tab(text: 'For You'),
              Tab(text: 'Top Charts'),
              Tab(text: 'Events'),
              Tab(text: 'Kids'),
              Tab(text: 'Categories'),
            ],
          ),
        ],
      ),
    );
  }
}