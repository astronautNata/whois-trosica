import 'package:flutter/material.dart';
import 'package:whois_trosica/models/WhoisResponse.dart';

class WhoisCard extends StatelessWidget {
  final WhoisResponse whois;
  final bool? favorited;
  final VoidCallback? onFavoriteTap;

  const WhoisCard({
    Key? key,
    required this.whois,
    this.favorited,
    this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWhois(),
              if (favorited != null) _buildFavorite(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWhois() {
    return Flexible(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${whois.domen}',
            style: TextStyle(fontSize: 20),
          ),
          Text('${whois.owner}'),
          Text('${whois.registrar}'),
          Text('${whois.registrationDate}'),
          Text('${whois.expirationDate}'),
          Text('${whois.nameservers}'),
        ],
      ),
    );
  }

  Widget _buildFavorite() {
    return Flexible(
      flex: 1,
      child: IconButton(
        icon: Icon(favorited! ? Icons.favorite : Icons.favorite_border),
        onPressed: onFavoriteTap,
      ),
    );
  }
}
