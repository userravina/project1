# app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
<p>
<img src="https://user-images.githubusercontent.com/120082785/220397599-f5b30425-689b-459b-a885-142f62cde580.png" height="50%" width="30%">
<img src="https://user-images.githubusercontent.com/120082785/220398046-f935dcc0-6bfe-453e-8990-c8b968a9abf0.png" height="100%" width="30%">
</p>

class ProfileCardPainter extends CustomPainter {
  ProfileCardPainter({required this.color, required this.avatarRadius});

  final Color color;
  final double avatarRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final backgroundPath = Path();
    final cornerRadius = size.height / 2;
    final curveHeight = size.height * 0.3;
    backgroundPath.moveTo(0, size.height / 2);

    backgroundPath.arcToPoint(
      Offset(cornerRadius, 0),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    final halfWidth = size.width / 2;
    final halfSpace = size.width * 0.15;
    
    backgroundPath.lineTo(halfWidth - halfSpace, 0);

    backgroundPath.cubicTo(
      halfWidth - halfSpace * 0.6, 0,
      halfWidth - halfSpace * 0.4, curveHeight,
      halfWidth, curveHeight,
    );
    
    backgroundPath.cubicTo(
      halfWidth + halfSpace * 0.4, curveHeight,
      halfWidth + halfSpace * 0.6, 0,
      halfWidth + halfSpace, 0,
    );

    backgroundPath.lineTo(size.width - cornerRadius, 0);
    backgroundPath.arcToPoint(
      Offset(size.width, size.height / 2),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    backgroundPath.arcToPoint(
      Offset(size.width - cornerRadius, size.height),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );
    backgroundPath.lineTo(cornerRadius, size.height);
    backgroundPath.arcToPoint(
      Offset(0, size.height / 2),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    backgroundPath.close();
    canvas.drawPath(backgroundPath, paint);
    final reflectionPath = Path();
    final reflectionWidth = size.width * 0.1;
    final reflectionHeight = curveHeight * 0.8;
    
    reflectionPath.moveTo(halfWidth - reflectionWidth, curveHeight * 0.3);
    reflectionPath.cubicTo(
      halfWidth - reflectionWidth * 0.5, curveHeight * 0.3,
      halfWidth - reflectionWidth * 0.3, reflectionHeight,
      halfWidth, reflectionHeight
    );
    reflectionPath.cubicTo(
      halfWidth + reflectionWidth * 0.3, reflectionHeight,
      halfWidth + reflectionWidth * 0.5, curveHeight * 0.3,
      halfWidth + reflectionWidth, curveHeight * 0.3
    );

    final reflectionPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.005;

    canvas.drawPath(reflectionPath, reflectionPaint);
  }

  @override
  bool shouldRepaint(ProfileCardPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final navBarHeight = 80.0;
    final totalHeight = navBarHeight + bottomPadding + 50;

    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: totalHeight),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text('Home Page'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: totalHeight,
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: bottomPadding + 10,
              child: Container(
                width: screenWidth - 32,
                height: navBarHeight,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomPaint(
                  size: Size(screenWidth - 32, navBarHeight),
                  painter: ProfileCardPainter(
                    color: Colors.black,
                    avatarRadius: 10,
                  ),
                ),
              ),
            ),

            Positioned(
              top: -5,
              child: Material(
                color: Colors.transparent,
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.3),
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () {},
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: bottomPadding + 25,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 70,
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.15),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 70,
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: MediaQuery.of(context).size.width * 0.03,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.safety_check_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



CREATE TABLE blog_category (
    id SERIAL PRIMARY KEY,   -- Auto incrementing ID
    name VARCHAR(255) NOT NULL -- Category name (e.g., fashion, promo)
);

CREATE TABLE blog_post (
    id SERIAL PRIMARY KEY,   -- Auto incrementing ID
    category_id INT NOT NULL,   -- Foreign key to blog_category
    image_url TEXT,  -- URL to the main image of the blog post
    short_description TEXT,   -- Short description of the blog post
    long_description TEXT,    -- Full description of the blog post
    title VARCHAR(255) NOT NULL,  -- Title of the blog post
    published_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP, -- When the post was published
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES blog_category (id)
        ON DELETE CASCADE -- If a category is deleted, all related blog posts are deleted
);

CREATE TABLE blog_post_details (
    id SERIAL PRIMARY KEY,    -- Auto incrementing ID
    blog_post_id INT NOT NULL,   -- Foreign key to blog_post
    first_image_url TEXT,   -- URL for the first detailed image
    title VARCHAR(255) NOT NULL,  -- Title for the detailed blog content
    long_description_first TEXT,  -- First part of the detailed description
    second_image_url TEXT,  -- URL for the second detailed image
    long_description_second TEXT, -- Second part of the detailed description
    CONSTRAINT fk_blog_post
        FOREIGN KEY (blog_post_id)
        REFERENCES blog_post (id)
        ON DELETE CASCADE  -- If a blog post is deleted, its details are also deleted
);

INSERT INTO blog_post (category_id, image_url, short_description, long_description, title)
VALUES (1, 'http://example.com/image.jpg', 'This is a short description', 'This is a long description', 'Fashion Trends 2025');


