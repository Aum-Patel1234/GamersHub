import 'package:flutter/material.dart';
import 'package:gamers_hub/modules/models/games/games.dart';
import 'package:gamers_hub/modules/ui/shared/hero_cover.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.game, required this.coverUrl});

  final Games game;
  final String coverUrl;

  @override
  Widget build(BuildContext context) {
    // final double width = MediaQuery.of(context).size.width;
    // https://www.youtube.com/watch?v=bPFJuANnahE

    return Scaffold(
      appBar: AppBar(
        title: Text(game.name ?? "Game Details"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 200,
              // child: Youtube Video,
              color: Colors.red,
              child: HeroCover(heroTag: 'game_${game.id}', coverUrl: coverUrl,)
            ),

          ],
        )
      ),
    );
  }
}

/**
 * age ratings specifications
 * 
 * ESRB (Entertainment Software Rating Board) - Used in North America:

Three (1): Suitable for ages 3+.
Seven (2): Suitable for ages 7+.
Twelve (3): Suitable for ages 12+.
Sixteen (4): Suitable for ages 16+.
Eighteen (5): Suitable for ages 18+.
RP (6): Rating Pending (not yet officially rated).
EC (7): Early Childhood.
E (8): Everyone (ages 6+).
E10 (9): Everyone 10+.
T (10): Teen (ages 13+).
M (11): Mature (ages 17+).
AO (12): Adults Only (ages 18+).
CERO (Computer Entertainment Rating Organization) - Used in Japan:

CERO_A (13): Suitable for all ages.
CERO_B (14): Suitable for ages 12+.
CERO_C (15): Suitable for ages 15+.
CERO_D (16): Suitable for ages 17+.
CERO_Z (17): Suitable for ages 18+ (adults only).
USK (Unterhaltungssoftware Selbstkontrolle) - Used in Germany:

USK_0 (18): Suitable for all ages.
USK_6 (19): Suitable for ages 6+.
USK_12 (20): Suitable for ages 12+.
USK_16 (21): Suitable for ages 16+.
USK_18 (22): Suitable for ages 18+.
GRAC (Game Rating and Administration Committee) - Used in South Korea:

GRAC_ALL (23): Suitable for all ages.
GRAC_Twelve (24): Suitable for ages 12+.
GRAC_Fifteen (25): Suitable for ages 15+.
GRAC_Eighteen (26): Suitable for ages 18+.
GRAC_TESTING (27): For games undergoing evaluation.
CLASS_IND (ClassInd) - Used in Brazil:

CLASS_IND_L (28): Suitable for all ages.
CLASS_IND_Ten (29): Suitable for ages 10+.
CLASS_IND_Twelve (30): Suitable for ages 12+.
CLASS_IND_Fourteen (31): Suitable for ages 14+.
CLASS_IND_Sixteen (32): Suitable for ages 16+.
CLASS_IND_Eighteen (33): Suitable for ages 18+.
ACB (Australian Classification Board) - Used in Australia:

ACB_G (34): General (suitable for all ages).
ACB_PG (35): Parental Guidance (suitable for children under adult supervision).
ACB_M (36): Mature (suitable for ages 15+).
ACB_MA15 (37): Restricted (suitable for ages 15+, but requires parental guidance).
ACB_R18 (38): Restricted (suitable for ages 18+).
ACB_RC (39): Refused Classification (banned or not suitable for release).
 */