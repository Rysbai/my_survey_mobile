import 'package:graphql/client.dart';
import 'package:neobissurvey/constants/shared_presences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final HttpLink _httpLink = HttpLink(uri: 'http://192.168.31.123:5000/graphql');
final AuthLink _authLink = AuthLink(getToken: () async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString(USER_TOKEN) ?? '';

  return token;
});
final Link _link = _authLink.concat(_httpLink);
final GraphQLClient client = GraphQLClient(cache: InMemoryCache(), link: _link);
