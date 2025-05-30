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

        return ListView.builder(                        // it is rebuilding the aldready builded widgets while pagination so try to improve
          itemCount: state.popularGames.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            final Games game = state.popularGames[index];
            // https://images.igdb.com/igdb/image/upload/t_1080p/co670h.jpg
            // log(state.covers.values.map((entry)=>entry.imageId).toString());
            final coverUrl = index < state.covers.length ? 'https://images.igdb.com/igdb/image/upload/t_1080p/${state.covers[game.id]?.imageId}.jpg' : '';

            return ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/game',
                  arguments: {'game': game, 'cover': coverUrl},
                );
              },
              leading: coverUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 25,
                      child: ClipOval(
                        child: Image(
                          image: NetworkImage(
                            coverUrl,
                          ),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                    )
                  : const Icon(Icons.image_not_supported),
              title: Text(
                game.name ?? "",
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(game.totalRating.toString()),
              trailing: Text((index + 1).toString()),
            );
          },
        );
      },
    );
  }
}
