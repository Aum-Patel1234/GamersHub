part of '../home_section_collection.dart';
class TopCharts extends StatelessWidget {
  const TopCharts({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopChartsBloc, TopChartsState>(
      builder: (context, state) {
        if (state.isLoading && state.popularGames.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: state.popularGames.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            final Games game = state.popularGames[index];
            final coverUrl = index < state.covers.length ? 'https:${state.covers[game.id]?.url}' : ''; 
        
            return ListTile(
              onTap: (){
                Navigator.pushNamed(context, 'game');
              },
              leading: coverUrl.isNotEmpty ? CircleAvatar(child: Image(image: NetworkImage(coverUrl),fit: BoxFit.contain,),) : const Icon(Icons.image_not_supported), 
              title: Text(game.name ?? "",overflow: TextOverflow.ellipsis,),
              subtitle: Text(game.rating.toString()),
              trailing: Text((index+1).toString()),
            );
          },
        );
      },
    );
  }
}
