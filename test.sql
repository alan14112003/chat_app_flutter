SELECT
    `Message`.*,
    `sender`.`id` AS `sender.id`,
    `sender`.`firstName` AS `sender.firstName`,
    `sender`.`lastName` AS `sender.lastName`,
    `sender`.`avatar` AS `sender.avatar`,
    `sender`.`email` AS `sender.email`,
    `reply`.`id` AS `reply.id`,
    `reply`.`userId` AS `reply.userId`,
    `reply`.`chatId` AS `reply.chatId`,
    `reply`.`text` AS `reply.text`,
    `reply`.`file` AS `reply.file`,
    `reply`.`image` AS `reply.image`,
    `reply`.`type` AS `reply.type`,
    `reply`.`replyId` AS `reply.replyId`,
    `reply`.`isRecall` AS `reply.isRecall`,
    `reply`.`isPinned` AS `reply.isPinned`,
    `reply`.`createdAt` AS `reply.createdAt`,
    `reply`.`updatedAt` AS `reply.updatedAt`,
    `reply->sender`.`id` AS `reply.sender.id`,
    `reply->sender`.`firstName` AS `reply.sender.firstName`,
    `reply->sender`.`lastName` AS `reply.sender.lastName`,
    `reply->sender`.`avatar` AS `reply.sender.avatar`,
    `reply->sender`.`email` AS `reply.sender.email`,
    `reactions`.`userId` AS `reactions.userId`,
    `reactions`.`messageId` AS `reactions.messageId`,
    `reactions`.`emojiId` AS `reactions.emojiId`,
    `reactions`.`MessageId` AS `reactions.MessageId`,
    `reactions->sender`.`id` AS `reactions.sender.id`,
    `reactions->sender`.`firstName` AS `reactions.sender.firstName`,
    `reactions->sender`.`lastName` AS `reactions.sender.lastName`,
    `reactions->sender`.`avatar` AS `reactions.sender.avatar`,
    `reactions->sender`.`email` AS `reactions.sender.email`,
    `reactions->emoji`.`id` AS `reactions.emoji.id`,
    `reactions->emoji`.`name` AS `reactions.emoji.name`,
    `reactions->emoji`.`src` AS `reactions.emoji.src`,
    `seens`.`id` AS `seens.id`,
    `seens`.`firstName` AS `seens.firstName`,
    `seens`.`lastName` AS `seens.lastName`,
    `seens`.`avatar` AS `seens.avatar`,
    `seens`.`email` AS `seens.email`
FROM
    (
        SELECT
            `Message`.`id`,
            `Message`.`userId`,
            `Message`.`chatId`,
            `Message`.`text`,
            `Message`.`file`,
            `Message`.`image`,
            `Message`.`type`,
            `Message`.`replyId`,
            `Message`.`isRecall`,
            `Message`.`isPinned`,
            `Message`.`createdAt`,
            `Message`.`updatedAt`
        FROM
            `Messages` AS `Message`
        WHERE
            (
                `Message`.`id` NOT IN (
                    SELECT
                        MessageDeleted.messageId
                    FROM
                        MessageDeleteds as MessageDeleted
                    WHERE
                        chatId = '3bf8c507-8ef0-4931-ac15-92672195cb20'
                        and userId = '7b63d6e8-7a1d-4d2e-936b-98f8da9e4720'
                )
            )
            AND `Message`.`chatId` = '3bf8c507-8ef0-4931-ac15-92672195cb20'
        ORDER BY
            `Message`.`id` DESC
        LIMIT
            '10'
    ) AS `Message`
    LEFT OUTER JOIN `Users` AS `sender` ON `Message`.`userId` = `sender`.`id`
    AND (`sender`.`deletedAt` IS NULL)
    LEFT OUTER JOIN `Messages` AS `reply` ON `Message`.`replyId` = `reply`.`id`
    AND `reply`.`id` NOT IN (
        SELECT
            MessageDeleted.messageId
        FROM
            MessageDeleteds as MessageDeleted
        WHERE
            chatId = Message.chatId
            and userId = '7b63d6e8-7a1d-4d2e-936b-98f8da9e4720'
    )
    LEFT OUTER JOIN `Users` AS `reply->sender` ON `reply`.`userId` = `reply->sender`.`id`
    AND (`reply->sender`.`deletedAt` IS NULL)
    LEFT OUTER JOIN `MessageReactions` AS `reactions` ON `Message`.`id` = `reactions`.`MessageId`
    LEFT OUTER JOIN `Users` AS `reactions->sender` ON `reactions`.`userId` = `reactions->sender`.`id`
    AND (`reactions->sender`.`deletedAt` IS NULL)
    LEFT OUTER JOIN `Emojis` AS `reactions->emoji` ON `reactions`.`emojiId` = `reactions->emoji`.`id`
    LEFT OUTER JOIN (
        `MessageSeens` AS `seens->MessageSeen`
        INNER JOIN `Users` AS `seens` ON `seens`.`id` = `seens->MessageSeen`.`UserId`
    ) ON `Message`.`id` = `seens->MessageSeen`.`MessageId`
    AND (`seens`.`deletedAt` IS NULL)
ORDER BY
    `Message`.`id` DESC;