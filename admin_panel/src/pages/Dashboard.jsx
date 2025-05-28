import { Box, Typography, useTheme } from "@mui/material";
import { tokens } from "../theme";
import Header from "../components/Header";
import LineChart from "../components/charts/lineChart";
import StatBox from "../components/StatBox";
import ProgressCircle from "../components/ProgressCircle";

import PeopleIcon from "@mui/icons-material/People";
import PersonAddIcon from "@mui/icons-material/PersonAdd";
import GroupIcon from "@mui/icons-material/Group";

const Dashboard = () => {
  const theme = useTheme();
  const colors = tokens(theme.palette.mode);
  return (
    <Box m="10px" sx={{ overflow: "hidden" }}>
      {/* HEADER */}
      <Box display="flex" justifyContent="space-between" alignItems="center">
        <Header title="DASHBOARD" />
      </Box>

      {/* GRID & CHARTS */}
      <Box
        display="grid"
        gridTemplateColumns="repeat(12, 1fr)"
        gridAutoRows="minmax(145px, auto)"
        gap="3px"
      >
        {/* ROW 1 - Центрированные блоки статистики */}
        <Box
          gridColumn="span 12"
          display="flex"
          justifyContent="center"
          alignItems="center"
          gap="20px"
          backgroundColor="transparent"
        >
          <Box
            width="30%"
            backgroundColor={colors.primary[400]}
            display="flex"
            alignItems="center"
            justifyContent="center"
            height="100%"
            borderRadius="4px"
          >
            <StatBox 
              title="5" 
              subtitle="Активные пользователи" 
              icon={<PeopleIcon sx={{ fontSize: "30px", color: colors.greenAccent[500] }} />}
            />
          </Box>
          <Box
            width="30%"
            backgroundColor={colors.primary[400]}
            display="flex"
            alignItems="center"
            justifyContent="center"
            height="100%"
            borderRadius="4px"
          >
            <StatBox 
              title="2" 
              subtitle="Новые регистрации" 
              icon={<PersonAddIcon sx={{ fontSize: "30px", color: colors.greenAccent[500] }} />}
            />
          </Box>
          <Box
            width="30%"
            backgroundColor={colors.primary[400]}
            display="flex"
            alignItems="center"
            justifyContent="center"
            height="100%"
            borderRadius="4px"
          >
            <StatBox 
              title="10" 
              subtitle="Всего пользователей" 
              icon={<GroupIcon sx={{ fontSize: "30px", color: colors.greenAccent[500] }} />}
            />
          </Box>
        </Box>

        {/* ROW 2 */}
        <Box
          gridColumn="span 12"
          gridRow="span 2"
          backgroundColor={colors.primary[400]}
        >
          <Box
            mt="25px"
            p="0 30px"
            display="flex"
            justifyContent="space-between"
            alignItems="center"
          >
            <Box>
              <Typography variant="h5" fontWeight="600" color={colors.grey[100]}>
                Активность пользователей
              </Typography>
              <Typography
                variant="h3"
                fontWeight="bold"
                color={colors.greenAccent[500]}
              >
                
              </Typography>
            </Box>
          </Box>
          <Box height="250px" m="-20px 0 0 0">
            <LineChart isDashboard={true} />
          </Box>
        </Box>

        {/* ROW 3 и 4 - Центрированная группа */}
        <Box
          gridColumn="span 12"
          display="grid"
          gridTemplateColumns="repeat(12, 1fr)"
          gridAutoRows="minmax(145px, auto)"
          gap="20px" 
        >
          {/* Пустое пространство слева */}
          <Box gridColumn="span 2" />
          
          {/* Блок с ProgressCircle */}
          <Box
            gridColumn="span 4"
            gridRow="span 2"
            backgroundColor={colors.primary[400]}
            p="30px"
          >
            <Box
              display="flex"
              flexDirection="column"
              alignItems="center"
              justifyContent="center"
              height="100%"
              width="100%"
            >
              <ProgressCircle size="125" />
              <Box 
                display="flex"
                flexDirection="column"
                alignItems="center"
                justifyContent="center"
                mt="20px"
                width="100%"
              >
                <Box 
                  display="flex"
                  gap="20px"
                  justifyContent="center"
                  flexWrap="wrap"
                  width="100%"
                  maxWidth="300px"
                >
                  <Box display="flex" alignItems="center">
                    <Box 
                      width="12px"
                      height="12px"
                      borderRadius="50%"
                      bgcolor={colors.blueAccent[500]}
                      mr="8px"
                    />
                    <Typography variant="body2" color={colors.grey[100]}>
                      Активные пользователи
                    </Typography>
                  </Box>
                  <Box display="flex" alignItems="center">
                    <Box 
                      width="12px"
                      height="12px"
                      borderRadius="50%"
                      bgcolor={colors.greenAccent[500]}
                      mr="8px"
                    />
                    <Typography variant="body2" color={colors.grey[100]}>
                      Неактивные пользователи
                    </Typography>
                  </Box>
                </Box>
              </Box>
            </Box>
          </Box>

          {/* Блок с видео */}
          <Box
            gridColumn="span 4"
            gridRow="span 2"
            backgroundColor={colors.primary[400]}
            padding="30px"
            display="flex"
            alignItems="center"
            justifyContent="center"
          >
            <Box textAlign="center" width="100%">
              <video
                autoPlay
                loop
                muted
                playsInline
                style={{
                  width: "100%",
                  maxWidth: "200px",
                  height: "auto",
                  borderRadius: "8px",
                  boxShadow: "0 4px 12px rgba(0, 0, 0, 0.2)",
                  objectFit: "cover",
                }}
              >
                <source src="../../assets/gekon.mp4" type="video/mp4" />
                Ваш браузер не поддерживает видео.
              </video>
            </Box>
          </Box>

          {/* Пустое пространство справа */}
          <Box gridColumn="span 2" />
        </Box>
      </Box>
    </Box>
  );
};

export default Dashboard;