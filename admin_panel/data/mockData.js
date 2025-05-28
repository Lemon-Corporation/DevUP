import { tokens } from "../theme";
export const mockDataContacts = [
  {
    id: 1,
    name: "John Smith",
    point: 85,
    email: "john.smith@example.com",
    userid: "jsmith123",
  },
  {
    id: 2,
    name: "Emily Johnson",
    point: 92,
    email: "emily.j@example.com",
    userid: "ejohnson456",
  },
  {
    id: 3,
    name: "Michael Brown",
    point: 78,
    email: "michael.b@example.com",
    userid: "mbrown789",
  },
  {
    id: 4,
    name: "Sarah Williams",
    point: 95,
    email: "sarah.w@example.com",
    userid: "swilliams321",
  },
  {
    id: 5,
    name: "David Miller",
    point: 88,
    email: "david.m@example.com",
    userid: "dmiller654",
  },
  {
    id: 6,
    name: "Jessica Davis",
    point: 76,
    email: "jessica.d@example.com",
    userid: "jdavis987",
  },
  {
    id: 7,
    name: "Robert Wilson",
    point: 91,
    email: "robert.w@example.com",
    userid: "rwilson234",
  },
  {
    id: 8,
    name: "Jennifer Taylor",
    point: 83,
    email: "jennifer.t@example.com",
    userid: "jtaylor567",
  },
  {
    id: 9,
    name: "Thomas Anderson",
    point: 89,
    email: "thomas.a@example.com",
    userid: "tanderson890",
  },
  {
    id: 10,
    name: "Lisa Martinez",
    point: 94,
    email: "lisa.m@example.com",
    userid: "lmartinez123",
  },
  {
    id: 11,
    name: "Daniel Clark",
    point: 80,
    email: "daniel.c@example.com",
    userid: "dclark456",
  },
];


export const mockPieData = [

  {
    id: "Django",
    label: "Django",
    value: 322,
    color: "hsl(291, 70%, 50%)",
  },
  {
    id: "React",
    label: "React",
    value: 503,
    color: "hsl(229, 70%, 50%)",
  },
  {
    id: "ML",
    label: "ML",
    value: 584,
    color: "hsl(344, 70%, 50%)",
  },
];


export const mockLineData = [
  {
    id: "react",
    color: tokens("dark").greenAccent[500],
    data: [
      { x: "jan", y: 101 },
      { x: "feb", y: 75 },
      { x: "mar", y: 36 },
      { x: "apr", y: 216 },
      { x: "may", y: 35 },
      { x: "jun", y: 236 },
      { x: "jul", y: 88 },
      { x: "aug", y: 232 },
      { x: "sep", y: 281 },
      { x: "oct", y: 100 },
      { x: "nov", y: 150 },
      { x: "dec", y: 100 },
    ],
  },
  {
    id: "ML",
    color: tokens("dark").blueAccent[300],
    data: [
      { x: "jan", y: 212 },
      { x: "feb", y: 190 },
      { x: "mar", y: 270 },
      { x: "apr", y: 9 },
      { x: "may", y: 75 },
      { x: "jun", y: 175 },
      { x: "jul", y: 33 },
      { x: "aug", y: 189 },
      { x: "sep", y: 97 },
      { x: "oct", y: 87 },
      { x: "nov", y: 1 },
      { x: "dec", y: 299 },
    ],
  },
  {
    id: "Django",
    color: tokens("dark").redAccent[200],
    data: [
      { x: "jan", y: 191 },
      { x: "feb", y: 136 },
      { x: "mar", y: 91 },
      { x: "apr", y: 190 },
      { x: "may", y: 211 },
      { x: "jun", y: 152 },
      { x: "jul", y: 189 },
      { x: "aug", y: 152 },
      { x: "sep", y: 8 },
      { x: "oct", y: 197 },
      { x: "nov", y: 107 },
      { x: "dec", y: 150 },
    ],
  },
];
