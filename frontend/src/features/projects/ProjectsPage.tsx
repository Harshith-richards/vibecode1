import { useQuery } from '@tanstack/react-query';
import { api } from '../../lib/api';

export const ProjectsPage = () => {
  const q = useQuery({ queryKey: ['projects'], queryFn: async () => (await api.get('/api/projects')).data });
  return <div className="p-8"><h1 className="text-2xl mb-4">Projects</h1><pre>{JSON.stringify(q.data ?? [], null, 2)}</pre></div>;
};
