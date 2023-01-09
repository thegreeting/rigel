import 'dart:convert' show jsonEncode, jsonDecode;

import 'package:altair/logger.dart';
import 'package:ipfs_client_flutter/ipfs_client_flutter.dart';

class IpfsConnector {
  IpfsConnector({IpfsClient? client})
      : client = client ??
            IpfsClient(
              url: 'https://ipfs.infura.io:5001',
              authorizationToken:
                  'MksyeUZxdVFZcUN5WEFLZ3JuZmFyeERFdmVtOjliNDBmY2ZmZDUwNzJiMzUyMjUxMmNlNjViZjgwOWQ5', // Base64 encoded string of "username:password"
            );

  late final IpfsClient? client;

  Future<String> addJson(Map<String, dynamic> data) async {
    final dataToWrite = {'file': jsonEncode(data)};
    final result = await client?.add(data: dataToWrite) as Object;

    if (result is Map<String, dynamic> && result.containsKey('Hash')) {
      final cid = result['Hash']!.toString();
      logger.info('IPFS CID: $cid');
      return cid;
    }
    throw Exception('Failed to add data to IPFS');
  }

  Future<Map<String, dynamic>> catJson(String cid) async {
    final result = await client?.cat(hash: cid) as Future<dynamic>;
    try {
      final json = jsonDecode(result.toString()) as Map<String, dynamic>;
      return json;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      throw Exception('Invalid format data from IPFS');
    }
  }
}
