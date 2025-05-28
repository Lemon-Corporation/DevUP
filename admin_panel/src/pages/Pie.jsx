import { Box } from "@mui/material";
import Header from "../components/Header";
import PieChart from "../components/charts/PieChart";

const Pie = () => {
  return (
    <Box m="20px">
      <Header title="Pie Chart" subtitle="Распределение пользователей по курсам" />
      <Box height="75vh">
        <PieChart />
      </Box>
    </Box>
  );
};

export default Pie;
