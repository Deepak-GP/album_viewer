class AppConstants {
  // API URLs
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String albumsEndpoint = '/albums';
  static const String photosEndpoint = '/photos';

  // Fallback image URL
  static const String fallbackImageUrl = 'https://dummyimage.com/';

  // Hive box names
  static const String albumsBoxName = 'albums_box';
  static const String photosBoxName = 'photos_box';

  // Cache keys
  static const String albumsCacheKey = 'albums_cache';
  static const String photosCacheKey = 'photos_cache';

  static List<dynamic> mockAlbumData = [
    {"userId": 1, "id": 1, "title": "quidem molestiae enim"},
    {"userId": 1, "id": 2, "title": "sunt qui excepturi placeat culpa"},
    {"userId": 1, "id": 3, "title": "omnis laborum odio"},
    {"userId": 1, "id": 4, "title": "non esse culpa molestiae omnis sed optio"},
    {"userId": 1, "id": 5, "title": "eaque aut omnis a"},
    {"userId": 1, "id": 6, "title": "natus impedit quibusdam illo est"},
    {"userId": 1, "id": 7, "title": "quibusdam autem aliquid et et quia"},
    {"userId": 1, "id": 8, "title": "qui fuga est a eum"},
    {"userId": 1, "id": 9, "title": "saepe unde necessitatibus rem"},
    {"userId": 1, "id": 10, "title": "distinctio laborum qui"},
    {
      "userId": 2,
      "id": 11,
      "title": "quam nostrum impedit mollitia quod et dolor"
    },
    {
      "userId": 2,
      "id": 12,
      "title": "consequatur autem doloribus natus consectetur"
    },
    {
      "userId": 2,
      "id": 13,
      "title": "ab rerum non rerum consequatur ut ea unde"
    },
    {"userId": 2, "id": 14, "title": "ducimus molestias eos animi atque nihil"},
    {
      "userId": 2,
      "id": 15,
      "title": "ut pariatur rerum ipsum natus repellendus praesentium"
    },
    {
      "userId": 2,
      "id": 16,
      "title": "voluptatem aut maxime inventore autem magnam atque repellat"
    },
    {"userId": 2, "id": 17, "title": "aut minima voluptatem ut velit"},
    {"userId": 2, "id": 18, "title": "nesciunt quia et doloremque"},
    {
      "userId": 2,
      "id": 19,
      "title": "velit pariatur quaerat similique libero omnis quia"
    },
    {"userId": 2, "id": 20, "title": "voluptas rerum iure ut enim"},
    {
      "userId": 3,
      "id": 21,
      "title":
          "repudiandae voluptatem optio est consequatur rem in temporibus et"
    },
    {"userId": 3, "id": 22, "title": "et rem non provident vel ut"},
    {"userId": 3, "id": 23, "title": "incidunt quisquam hic adipisci sequi"},
    {"userId": 3, "id": 24, "title": "dolores ut et facere placeat"},
    {
      "userId": 3,
      "id": 25,
      "title": "vero maxime id possimus sunt neque et consequatur"
    },
    {"userId": 3, "id": 26, "title": "quibusdam saepe ipsa vel harum"},
    {"userId": 3, "id": 27, "title": "id non nostrum expedita"},
    {
      "userId": 3,
      "id": 28,
      "title": "omnis neque exercitationem sed dolor atque maxime aut cum"
    },
    {
      "userId": 3,
      "id": 29,
      "title": "inventore ut quasi magnam itaque est fugit"
    },
    {
      "userId": 3,
      "id": 30,
      "title": "tempora assumenda et similique odit distinctio error"
    },
    {"userId": 4, "id": 31, "title": "adipisci laborum fuga laboriosam"},
    {
      "userId": 4,
      "id": 32,
      "title": "reiciendis dolores a ut qui debitis non quo labore"
    },
    {"userId": 4, "id": 33, "title": "iste eos nostrum"},
    {
      "userId": 4,
      "id": 34,
      "title": "cumque voluptatibus rerum architecto blanditiis"
    },
    {
      "userId": 4,
      "id": 35,
      "title": "et impedit nisi quae magni necessitatibus sed aut pariatur"
    },
    {"userId": 4, "id": 36, "title": "nihil cupiditate voluptate neque"},
    {"userId": 4, "id": 37, "title": "est placeat dicta ut nisi rerum iste"},
    {"userId": 4, "id": 38, "title": "unde a sequi id"},
    {
      "userId": 4,
      "id": 39,
      "title": "ratione porro illum labore eum aperiam sed"
    },
    {"userId": 4, "id": 40, "title": "voluptas neque et sint aut quo odit"},
    {
      "userId": 5,
      "id": 41,
      "title":
          "ea voluptates maiores eos accusantium officiis tempore mollitia consequatur"
    },
    {"userId": 5, "id": 42, "title": "tenetur explicabo ea"},
    {"userId": 5, "id": 43, "title": "aperiam doloremque nihil"},
    {
      "userId": 5,
      "id": 44,
      "title":
          "sapiente cum numquam officia consequatur vel natus quos suscipit"
    },
    {
      "userId": 5,
      "id": 45,
      "title": "tenetur quos ea unde est enim corrupti qui"
    },
    {"userId": 5, "id": 46, "title": "molestiae voluptate non"},
    {"userId": 5, "id": 47, "title": "temporibus molestiae aut"},
    {
      "userId": 5,
      "id": 48,
      "title":
          "modi consequatur culpa aut quam soluta alias perspiciatis laudantium"
    },
    {
      "userId": 5,
      "id": 49,
      "title": "ut aut vero repudiandae voluptas ullam voluptas at consequatur"
    },
    {"userId": 5, "id": 50, "title": "sed qui sed quas sit ducimus dolor"}
  ];

  static List<dynamic> mockPhotoData = [
    {
      "albumId": 1,
      "id": 1,
      "title": "accusamus beatae ad facilis cum similique qui sunt",
      "url": "https://via.placeholder.com/600/92c952",
      "thumbnailUrl": "https://via.placeholder.com/150/92c952"
    },
    {
      "albumId": 1,
      "id": 2,
      "title": "reprehenderit est deserunt velit ipsam",
      "url": "https://via.placeholder.com/600/771796",
      "thumbnailUrl": "https://via.placeholder.com/150/771796"
    },
    {
      "albumId": 1,
      "id": 3,
      "title": "officia porro iure quia iusto qui ipsa ut modi",
      "url": "https://via.placeholder.com/600/24f355",
      "thumbnailUrl": "https://via.placeholder.com/150/24f355"
    },
    {
      "albumId": 1,
      "id": 4,
      "title": "culpa odio esse rerum omnis laboriosam voluptate repudiandae",
      "url": "https://via.placeholder.com/600/d32776",
      "thumbnailUrl": "https://via.placeholder.com/150/d32776"
    },
    {
      "albumId": 1,
      "id": 5,
      "title": "natus nisi omnis corporis facere molestiae rerum in",
      "url": "https://via.placeholder.com/600/f66b97",
      "thumbnailUrl": "https://via.placeholder.com/150/f66b97"
    },
    {
      "albumId": 1,
      "id": 6,
      "title": "accusamus ea aliquid et amet sequi nemo",
      "url": "https://via.placeholder.com/600/56a8c2",
      "thumbnailUrl": "https://via.placeholder.com/150/56a8c2"
    },
    {
      "albumId": 1,
      "id": 7,
      "title":
          "officia delectus consequatur vero aut veniam explicabo molestias",
      "url": "https://via.placeholder.com/600/b0f7cc",
      "thumbnailUrl": "https://via.placeholder.com/150/b0f7cc"
    },
    {
      "albumId": 1,
      "id": 8,
      "title": "aut porro officiis laborum odit ea laudantium corporis",
      "url": "https://via.placeholder.com/600/54176f",
      "thumbnailUrl": "https://via.placeholder.com/150/54176f"
    },
    {
      "albumId": 1,
      "id": 9,
      "title": "qui eius qui autem sed",
      "url": "https://via.placeholder.com/600/51aa97",
      "thumbnailUrl": "https://via.placeholder.com/150/51aa97"
    },
    {
      "albumId": 1,
      "id": 10,
      "title": "beatae et provident et ut vel",
      "url": "https://via.placeholder.com/600/810b14",
      "thumbnailUrl": "https://via.placeholder.com/150/810b14"
    },
    {
      "albumId": 1,
      "id": 11,
      "title": "nihil at amet non hic quia qui",
      "url": "https://via.placeholder.com/600/1ee8a4",
      "thumbnailUrl": "https://via.placeholder.com/150/1ee8a4"
    },
    {
      "albumId": 1,
      "id": 12,
      "title":
          "mollitia soluta ut rerum eos aliquam consequatur perspiciatis maiores",
      "url": "https://via.placeholder.com/600/66b7d2",
      "thumbnailUrl": "https://via.placeholder.com/150/66b7d2"
    },
    {
      "albumId": 1,
      "id": 13,
      "title": "repudiandae iusto deleniti rerum",
      "url": "https://via.placeholder.com/600/197d29",
      "thumbnailUrl": "https://via.placeholder.com/150/197d29"
    },
    {
      "albumId": 1,
      "id": 14,
      "title": "est necessitatibus architecto ut laborum",
      "url": "https://via.placeholder.com/600/61a65",
      "thumbnailUrl": "https://via.placeholder.com/150/61a65"
    },
    {
      "albumId": 1,
      "id": 15,
      "title": "harum dicta similique quis dolore earum ex qui",
      "url": "https://via.placeholder.com/600/f9cee5",
      "thumbnailUrl": "https://via.placeholder.com/150/f9cee5"
    },
    {
      "albumId": 1,
      "id": 16,
      "title":
          "iusto sunt nobis quasi veritatis quas expedita voluptatum deserunt",
      "url": "https://via.placeholder.com/600/fdf73e",
      "thumbnailUrl": "https://via.placeholder.com/150/fdf73e"
    },
    {
      "albumId": 1,
      "id": 17,
      "title": "natus doloribus necessitatibus ipsa",
      "url": "https://via.placeholder.com/600/9c184f",
      "thumbnailUrl": "https://via.placeholder.com/150/9c184f"
    },
    {
      "albumId": 1,
      "id": 18,
      "title": "laboriosam odit nam necessitatibus et illum dolores reiciendis",
      "url": "https://via.placeholder.com/600/1fe46f",
      "thumbnailUrl": "https://via.placeholder.com/150/1fe46f"
    },
    {
      "albumId": 1,
      "id": 19,
      "title": "perferendis nesciunt eveniet et optio a",
      "url": "https://via.placeholder.com/600/56acb2",
      "thumbnailUrl": "https://via.placeholder.com/150/56acb2"
    },
    {
      "albumId": 1,
      "id": 20,
      "title":
          "assumenda voluptatem laboriosam enim consequatur veniam placeat reiciendis error",
      "url": "https://via.placeholder.com/600/8985dc",
      "thumbnailUrl": "https://via.placeholder.com/150/8985dc"
    }
  ];
}
