class Review {
  final int reviewId;
  final int bookingId;
  final String review;
  final int stars;

  Review({
    required this.reviewId,
    required this.bookingId,
    required this.review,
    required this.stars,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewId: json['reviewId'] as int? ?? 0,
      bookingId: json['bookingId'] as int? ?? 0,
      review: json['review'] as String? ?? '',
      stars: json['stars'] as int? ?? 0,
    );
  }
}
