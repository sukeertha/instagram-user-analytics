# 1.top 5 oldest users
select * from users order by  created_at  limit 5;
use ig_clone
# 2.users who have never posted a single photo on Instagram.
select users.id, users.username  from users left join photos 
on users.id = photos.user_id where photos.id is null;

# 3. photo with most likes
select users.username, likes.photo_id, photos.image_url,
 count(likes.photo_id) as total
from photos inner join likes on likes.photo_id = photos.id inner join users on photos.user_id= users.id group by photos.id 
order by total desc limit 1;

#  4.Identify and suggest the top five most commonly used hashtags on the platform
select tag_name, count(tag_id) as total  from tags left join photo_tags
on tags.id = photo_tags.tag_id group by tag_name order by total desc limit 5;


# 5. day of the week most users registered
select dayname(created_at) as day , count(*) as total_users from users 
group by day order by total_users desc ;



# 6.calculate the average number of posts per user on Instagram. also provide total no of photos on Instagram divided by the total number of users
select 
((select count(*) from photos) / (select count(*) from users)) as average_photos_per_users
((select count(image_url) from photos) / (select count(distinct user_id) from photos)) as average_no_of_posts_per_users

# 7. identify users who have liked every single photo on the site.
 
 select likes.user_id , users.username from likes inner join users
 on users.id = likes.user_id group by users.id 
 having count(likes.photo_id) = (select count(id) from photos)
