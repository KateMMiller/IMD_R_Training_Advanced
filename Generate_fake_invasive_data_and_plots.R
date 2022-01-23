# Fake invasive data 
Plot_Name <- c(rep(paste0(rep("ACAD-", 50), sprintf("%02d", 1:50)), each = 3),
               rep(paste0(rep("MABI-", 12), sprintf("%02d", 1:12)), each = 3),
               rep(paste0(rep("SARA-", 24), sprintf("%02d", 1:24)), each = 3))
park <- substr(Plot_Name, 1, 4)
cycle <- rep(1:3, times = length(Plot_Name)/3)
inv_cover <- c(rnorm(150, 5, 2) + -1.5*cycle[1:150], # adding negative trend
               rnorm(36, 10, 2), # no trend 
               rnorm(72, 10, 4)) # no trend

invdata <- data.frame(Plot_Name, park, cycle, inv_cover)

head(invdata)
table(invdata$Plot_Name, invdata$cycle)

invplot_all <- ggplot(invdata, aes(x = cycle, y = inv_cover, group = Plot_Name)) +
  geom_point(aes(color = park)) +
  scale_color_manual(values = c("#69A466", "#8BB3CE", "#F5C76C"), name = "Park") +
  theme_bw()+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  labs(x = 'Cycle', y = "Invasive % Cover") +
  scale_x_continuous(limits = c(1, 3), breaks = c(1, 2, 3)) +
  geom_smooth(aes(x = cycle, y = inv_cover, group = park),
              formula = y ~ x,
              method = 'lm', se = FALSE, color = '#7E7E7E')+
  facet_wrap(~park)

invplot_ACAD <- ggplot(invdata %>% filter(park == "ACAD"), 
                       aes(x = cycle, y = inv_cover, group = Plot_Name))+
  geom_point(color = "#69A466") +
  geom_line(aes(group = Plot_Name), color = "#69A466", alpha = 0.5) +
  theme_bw()+
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank()) +
  labs(x = 'Cycle', y = "Invasive % Cover") +
  scale_x_continuous(limits = c(1, 3), breaks = c(1, 2, 3)) +
  geom_smooth(aes(x = cycle, y = inv_cover, group = park),
              formula = y ~ x,
              method = 'lm', se = FALSE, color = '#7E7E7E')+
  facet_wrap(~park)