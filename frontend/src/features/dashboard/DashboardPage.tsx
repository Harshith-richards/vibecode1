import { Bar, BarChart, CartesianGrid, ResponsiveContainer, XAxis, YAxis } from 'recharts';

const data = [
  { month: 'Jan', docs: 420 },
  { month: 'Feb', docs: 520 },
  { month: 'Mar', docs: 610 }
];

export const DashboardPage = () => (
  <div className="p-8">
    <h1 className="text-3xl font-bold mb-4">Enterprise Dashboard</h1>
    <div className="bg-white p-4 rounded shadow h-72">
      <ResponsiveContainer width="100%" height="100%">
        <BarChart data={data}><CartesianGrid strokeDasharray="3 3" /><XAxis dataKey="month" /><YAxis /><Bar dataKey="docs" fill="#2563eb" /></BarChart>
      </ResponsiveContainer>
    </div>
  </div>
);
