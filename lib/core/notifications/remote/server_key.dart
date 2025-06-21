import 'package:googleapis_auth/auth_io.dart';

class ServerKey {

  static Future<String> getServerToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson(
            {
              "type": "service_account",
              "project_id": "notifications-7ae71",
              "private_key_id": "d53abb50c68ef09f553cad0dde3982ab5f72dbc1",
              "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCpnLrfAV/PD7DX\nAOednDAKswXVKv08BQ8RWg1hdMB48WOKD5gv7ccZMrCEpWxfsIvb6jbvlIlu3RZ+\n+E1vPcx+mYoRsV9mARjynbRv+WwwUz/zyD/zwzUJg8Tm0CE+P0w6wUOAjNf4YOJ6\n68VoiiyaCyC/vvEpoht04BsgMr+bptb61o1cXDltEx/8wEdppR4GUEIq2+NG/N92\nlC4lM2wip8FlafG7HN8svyH6hWSSWWsojAkzFuTYvwMKBvps1qe8hPPgHhVeIPsE\n4rciVjuztTyolB+d05E2k0LJPZ6mWaLFC3xEa3ppLcgBvdB0fnGN3LsJ1LTcxwfI\nhYZUGG/LAgMBAAECggEAUgF/zovFDYGKIGIFGkymY73r34WR+598igiuuIRw/OjF\nFj7095Nw9ItwEipDLD7ZWEI1Pn/kNPB7THd0RQktorZMrcJDHDgCnmdGku8W8oSF\nwrH6zbp/nbKSlIBj2ktTaYMAxpoSX7pENmdhQmqwJuijdGH3CwigWtFx/A7dWn02\nKnjnq210YXNl++4R0fFcepfKVARtXKnR9EGEu+lEZwhWDG+4h532Xz0iWJxvLuy/\nuJCaqasl/fKCS46y01LYlIUBkAIC/YVq3sl2ad51/LZ9O50G9koEvg5qRIP7Z7dr\nvYuTDkwPSekyI+ObgwiyhFJd7LrYoKSr5gVTo9d5AQKBgQDRh4NhHbGrmkTmM8Ed\nbne+2n2R+WYKqxdyhDZ5+cjyTygT9D3t6OWOBnY0UGhkMP8ieQjXbySK3gzkYa4U\n9yCYEqxE0Op7P8SdQu8GUr4nQRPqaT/JBZff3RCpbMqhBasQBxY3qoXtc0HG1uEz\nIkj2wjghUMk7xcnS/dbc9VDZAQKBgQDPOtW8G4dsYW24hi+OWz60ylRoYRKffiCJ\nJXqfiTgJA7q2EYM6yPD3xr+2Hk0jg3vMkjcAi4cH4dktK9fzMr7ppOGO4D+9r9GO\nIUA6FMGzZk0znEQO47/IV6Fm+d+aeo3EprhLNwkEdJ6HdVhy0dJJmOtBM+0vd/gC\n0AM/vwBcywKBgCy+XnzfpXA6ulnaVXPegi28ZLJGatb+YDxxJVz4zUOJScqxDoR+\nhn7EvHtBbHlwyRroc83liw0oi+I9RbpuZ4RyAF2Vq2z0Wh0nDPnxs2+YgxM8tIVN\n73e7snIrrD2kgzoh+Umb3YuuYC6A9og/2wruwKPEp6RfAVFQKZD3xfMBAoGBAJGw\nwHFWPVhSCuyO0kJYHfbGxJ75mDkvWDpzcglVVGLqD0tPdp5OhTL9tOyZ0wujtda1\n+RtV/OHqw1/Bkjo1tAjZVYa4W7fFMyOkdt4el6vDwYUGWMbLEZsNGLkn9S9K9/6I\nY8rlb16FiqqbMkrO/vOlIcgedKNJycBYc+BOLTgPAoGBAIMWkTxAdVNiYkQzfa8o\nDTYra0nvrns0qPzg1T2NcXL9zFGommeXWed4GnmmlmubrMOfP1c/A0BofS7nOXug\nYtbjOiFAhHDvKDsSCIfVbzvnGcfWpn8vNPKnqT4o80mVpzkv3jcJmF/4SZzyljTc\nqAg6P80fgWs25xs0o7H5v9z/\n-----END PRIVATE KEY-----\n",
              "client_email": "firebase-adminsdk-fbsvc@notifications-7ae71.iam.gserviceaccount.com",
              "client_id": "111385082543071689415",
              "auth_uri": "https://accounts.google.com/o/oauth2/auth",
              "token_uri": "https://oauth2.googleapis.com/token",
              "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
              "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40notifications-7ae71.iam.gserviceaccount.com",
              "universe_domain": "googleapis.com"
            }
        ),
        scopes);
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}