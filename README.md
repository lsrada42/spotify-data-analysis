# Spotify Track and Artist Trend Analysis Using Python and SQL
*Built a data pipeline with Python ETL and analyzed track and artist trends using SQL*

### Overview
This project explores a comprehensive Spotify music dataset to derive insights into artist popularity, track characteristics, and user engagement. The goal was to build a data pipeline that extracts, transforms, and loads the dataset into a SQL database, followed by performing SQL queries to analyze streaming trends, track statistics, and album performance.

### Data Acquisition and Processing
A complete ETL (Extract, Transform, Load) process was implemented:

- Extract: The dataset was sourced using the Kaggle API.
- Transform: Data was cleaned and transformed using Python to handle missing values, standardize columns, and prepare it for structured analysis.
- Load: The cleaned data was loaded into SQL Server to facilitate efficient querying and advanced analytics.


### Tools and Technologies

#### Data Source: Spotify Music Dataset (Kaggle)

#### Technologies Used:
- Python (ETL and data transformation)
- Kaggle API (Data extraction)
- MySQL Server (Data storage and analysis)
- SQL (Complex queries and aggregations)

### Database Schema
The dataset was stored in the df_spotify table, with the following attributes:

- Artist and Track Details: artist, track, album, release_year
- Engagement Metrics: views, likes, comments, streams, official_video, licensed
- Music Features: energy, danceability, tempo, liveness, valence, loudness
- Platform Comparison: most_playedon, yt_streams, spotify_streams

### Analytical Queries and Insights
1. 🎧 Top Artists and Their Billion-Stream Tracks:
Tracks by The Weeknd, Ed Sheeran, and Post Malone dominate the billion-stream club, with "Blinding Lights" by The Weeknd leading the list.

2. 📊 Total Views, Likes, and Comments by Artist:
Ed Sheeran tops the list with over 15 billion views, followed by CoComelon and Katy Perry. High engagement (likes and comments) is observed for global pop artists.

3. 🎼 Average Music Features per Artist: 
Daft Punk and Pitbull exhibit higher energy and danceability, while Coldplay and Radiohead have tracks with lower tempos.

4. 🎬 Tracks with Official Videos and Their Engagement: 
Tracks with official videos, such as "Despacito," accumulate significantly higher views and likes, indicating strong audience preference for visual content.

5. 🔥 Top 5 Tracks with the Highest Energy: 
Interestingly, relaxation music, such as "Rain and Thunderstorm" and "Gentle Piano Melodies," tops the energy chart, likely due to misclassification or a skew in dataset energy definitions.

6. 🎤 Tracks with Above-Average Liveness: 
Live performances and remixes, such as "Feel Good Inc." and "Dani California," have higher liveness scores, suggesting a dynamic and interactive sound profile.

7. 📈 Average Streams Comparison for Tracks with and Without Official Videos: 
Tracks with official videos tend to have significantly higher average streams compared to those without official videos, emphasizing the visual element’s contribution to popularity.

8. 💬 Comparison Between Licensed and Non-Licensed Tracks (Comments): 
Licensed tracks generate substantially more comments on average than non-licensed tracks. Notably, tracks like "Blinding Lights" and "Shape of You" have exceptionally high comment counts.

9. 🎥 Spotify vs. YouTube Streams Comparison: 
Tracks such as "Without Me," "Silence," and "Color Esperanza 2020" are streamed more frequently on Spotify than on YouTube, indicating higher preference on Spotify for these tracks.

10. ⚡️ Difference Between Highest and Lowest Energy Tracks in Albums: 
Albums such as "White Noise" and "Spotify Singles" exhibit the highest energy variation, showcasing diverse musical range across tracks.

11. 🎹 Artist Efficiency Score (Stream per Track): 
Post Malone ranks highest in stream-per-track efficiency, followed closely by Ed Sheeran and Dua Lipa, indicating their consistent ability to generate high streams across their discography.

12. 🎵 Most Engaging Tracks (Likes-to-Views Ratio): 
Tracks with high likes-to-views ratios, such as "Safety Zone," "Future," and "Pandora's Box," indicate strong audience appreciation and potential for viral success.

### 🎯 Key Insights Summary: 
- Track Popularity: Billion-stream tracks are concentrated among a few global artists.
- User Engagement: Higher views correlate with increased likes and comments, especially for licensed and official video tracks.
- Musical Characteristics: Tracks with higher liveness and energy tend to attract more streams.
- Platform Comparison: Spotify has higher streaming numbers for certain tracks, whereas YouTube dominates others.
- Artist Efficiency: Post Malone and Ed Sheeran demonstrate consistent stream-per-track efficiency, making them top-performing artists.
- Visual Impact: Official videos significantly boost track engagement and viewership.
- Engagement Metrics: High likes-to-views ratios indicate stronger user engagement and virality potential.

### 📚 Conclusion
This project highlights the effectiveness of SQL in deriving meaningful insights from Spotify music data. Through an end-to-end ETL pipeline and sophisticated SQL queries, the analysis revealed key trends in streaming patterns, user engagement, and track performance. These insights can guide data-driven decisions for content creators, record labels, and streaming platforms.
