USE XuBookstore;

DELETE FROM book;
ALTER TABLE book AUTO_INCREMENT = 1001;

DELETE FROM category;
ALTER TABLE category AUTO_INCREMENT = 1001;

INSERT INTO `category` (`name`) VALUES ('Fiction'),('Biography'),('Business'),('History'), ('Mystery & Crime'), ('Romance');

INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Migrations', 'Charlotte McConaghy', 1249, TRUE, 1001);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The Girl with the Louding Voice', 'Abi Daré', 1700, FALSE, 1001);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Hidden Valley Road', 'Robert Kolker', 2149, TRUE, 1001);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The Ballad of Songbirds and Snakes', 'Suzanne Collins', 2149, TRUE, 1001);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Deacon King Kong', 'James McBride', 1972, FALSE, 1002);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Pretty Things', 'Janelle Brown', 2275, FALSE, 1002);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Writers & Lovers', 'Lily King', 1700, TRUE, 1002);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The Mercies', 'Kirin Millwood Hargrave', 2346, TRUE, 1004);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Apeirogon', 'Colum McCann', 1989, FALSE, 1004);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Things in Jars', 'Jess Kidd', 1699, FALSE, 1004);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The City We Became', 'N. K. Jemisin', 1799, TRUE, 1004);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Oona Out of Order', 'Margarita Montimore', 1799, FALSE, 1005);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The Big Book of Serial Killers', 'Jack Rosewood', 1796, FALSE, 1005);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The Last Sister', 'Kendra Elliot', 1459, TRUE, 1005);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The Last Thing She Ever Did', 'Gregg Olsen', 1199, TRUE, 1005);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The Giver of Stars', 'Jojo Moyes', 1402, FALSE, 1006);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Beach Read', 'Emily Henry', 849, TRUE, 1006);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Playing with Fire', 'L.J. Shen', 1439, FALSE, 1006);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Redeeming Love', 'Francine Rivers', 1178, FALSE, 1006);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Liar Poker', 'Michael Lewis', 1457, TRUE, 1003);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('The Art Of War', 'Sun Tzu', 398, FALSE, 1003);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Emotional Intelligence 2.0', 'Travis Bradberry', 1669, TRUE, 1003);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Devil Take the Hindmost', 'Edward Chancellor', 1710, FALSE, 1003);
INSERT INTO `book` (title, author, price, is_public, category_id) VALUES ('Alexander Hamilton', 'Ron Chernow', 1320, FALSE, 1002);

