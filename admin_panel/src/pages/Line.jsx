import { Box } from "@mui/material";
import Header from "../components/Header";
import LineChart from "../components/charts/lineChart";

const Line = () => {
  return (
    <Box m="20px">
      <Header title="Line Chart" subtitle="Активность пользователей" />
      <Box height="75vh">
        <LineChart />
      </Box>
    </Box>
  );
};

export default Line;
