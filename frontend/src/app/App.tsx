import { Link, Route, Routes } from 'react-router-dom';
import { LoginPage } from '../features/auth/LoginPage';
import { DashboardPage } from '../features/dashboard/DashboardPage';
import { ProjectsPage } from '../features/projects/ProjectsPage';
import { DocumentsPage } from '../features/documents/DocumentsPage';

export const App = () => (
  <div className="min-h-screen bg-slate-100 text-slate-900">
    <nav className="p-4 flex gap-4 bg-white shadow">
      <Link to="/">Dashboard</Link>
      <Link to="/projects">Projects</Link>
      <Link to="/documents">Documents</Link>
      <Link to="/login">Login</Link>
    </nav>
    <Routes>
      <Route path="/" element={<DashboardPage />} />
      <Route path="/projects" element={<ProjectsPage />} />
      <Route path="/documents" element={<DocumentsPage />} />
      <Route path="/login" element={<LoginPage />} />
    </Routes>
  </div>
);
