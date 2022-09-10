class CommentModel {
  final String text;
  final double? identityAttack;
  final double? insult;
  final double? profanity;
  final double? severeToxicity;
  final double? threat;
  final double? toxicity;

  CommentModel({
    required this.text,
    required this.identityAttack,
    required this.insult,
    required this.profanity,
    required this.severeToxicity,
    required this.threat,
    required this.toxicity,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      text: json['text'],
      // [identityAttack] Negative or hateful comments targeting someone because of their identity.
      identityAttack: json['attribute_scores'] == null
          ? null
          : json['attribute_scores']['IDENTITY_ATTACK'],
      // [insult] Insulting, inflammatory, or negative comment towards a person or a group of people.
      insult: json['attribute_scores'] == null
          ? null
          : json['attribute_scores']['INSULT'],
      // [profanity] Swear words, curse words, or other obscene or profane language.
      profanity: json['attribute_scores'] == null
          ? null
          : json['attribute_scores']['PROFANITY'],
      // [severeToxicity] A very hateful, aggressive, disrespectful comment or otherwise very likely to make a user
      // leave a discussion or give up on sharing their perspective. This attribute is much less sensitive to more
      // mild forms of toxicity, such as comments that include positive uses of curse words.
      severeToxicity: json['attribute_scores'] == null
          ? null
          : json['attribute_scores']['SEVERE_TOXICITY'],
      // [threat] Describes an intention to inflict pain, injury, or violence against an individual or group.
      threat: json['attribute_scores'] == null
          ? null
          : json['attribute_scores']['THREAT'],
      // [toxicity] A rude, disrespectful, or unreasonable comment that is likely to make people leave a discussion.
      toxicity: json['attribute_scores'] == null
          ? null
          : json['attribute_scores']['TOXICITY'],
    );
  }
}
